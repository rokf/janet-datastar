(import spork/json)
(import spork/http)

(defn middleware
  "Parses the Datastar store and puts it under a :datastar key in the request table"
  [nextmw]
  (fn datastar-mw [req]
    (if (not= "true" (get-in req [:headers "datastar-request"] "false"))
      (nextmw req)
      (do
        (def store
          (case (get req :method)
            "GET" (json/decode (get-in req [:query "datastar"] "{}") true true)
            (json/decode (http/read-body req) true true)))
        (nextmw (table ;(kvs req) :datastar store))))))

(def headers {:cache-control "no-cache" :content-type "text/event-stream" :connection "keep-alive"})
