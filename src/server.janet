# This is a partial "fork" of spork/http, because some of the functionality
# didn't work well with Datastar or was missing. In case that the required
# tweaks ever land in spork/http this file will be removed.

(import spork/http)

(def- chunk-size (* 16 4096))

(defn- write-body
  "Write the body of an HTTP request, adding Content-Length header
  or Transfer-Encoding: chunked"
  [conn buf body]
  (cond
    (nil? body)
    (do
      (buffer/push buf "\r\n")
      (ev/write conn buf))

    (bytes? body)
    (do
      (buffer/format buf "Content-Length: %d\r\n\r\n%V" (length body) body)
      (ev/write conn buf))

    (= :core/channel (type body))
    (do
      # write headers
      (buffer/push buf "\r\n")
      (ev/write conn buf)
      # write channel contents
      (forever
        (def event (ev/take body))
        (if (nil? event) (do
                           (break)))
        (net/write conn event)))

    # otherwise expect an iterable
    (do
      (buffer/push buf "\r\n")
      (ev/write conn buf)
      (each chunk body
        (assert (bytes? chunk) "expected byte chunk")
        (net/write conn chunk))))
  (buffer/clear buf))

(defn send-response
  ``Send an HTTP response over a connection. Will automatically use chunked
  encoding if body is not a byte sequence. `response` should be a table
  with the following keys:

  * `:headers` - optional headers to write
  * `:status` - integer status code to write
  * `:body` - optional byte sequence or iterable (for chunked body)
     for returning contents. The iterable can be lazy, i.e. for streaming
     data.``
  [conn response &opt buf]
  (default buf @"")
  (def status (get response :status 200))
  (def message (in http/status-messages status))
  (buffer/format buf "HTTP/1.1 %d %s\r\n" status message)
  (def headers (get response :headers {}))
  (eachp [k v] headers
    (buffer/format buf "%V: %V\r\n" k v))
  (write-body conn buf (in response :body)))

(defn server-handler
  ``A simple connection handler for an HTTP server.
  When a connection is accepted. Call this with a handler
  function to handle the connect. The handler will be called
  with one argument, the request table, which will contain the
  following keys:
  * `:head-size` - number of bytes in the http header.
  * `:headers` - table mapping header names to header values.
  * `:connection` - the connection stream for the header.
  * `:buffer` - the buffer instance that may contain extra bytes.
  * `:path` - HTTP path.
  * `:method` - HTTP method, as a string.``
  [conn handler]
  (def handler (http/middleware handler))
  (defer (net/shutdown conn)

    # Get request header
    (def buf (buffer/new chunk-size))
    (def req (http/read-request conn buf))

    # Handle bad request
    (when (= :error req)
      (send-response conn {:status 400} (buffer/clear buf))
      (break))

    # Add some extra keys to the request
    (put req :connection conn)

    # Do something with request header
    (def response (handler req))

    # Now send back response
    (send-response conn response @"")))

(defn server
  "Makes a simple http server. By default it binds to 0.0.0.0:8000,
  returns a new server stream.
  Simply wraps http/server-handler with a net/server."
  [handler &opt host port]
  (default host "0.0.0.0")
  (default port 8000)
  (defn new-handler
    [conn]
    (server-handler conn handler))
  (net/server host port new-handler))
