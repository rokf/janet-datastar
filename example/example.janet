(import pat)
(import redka)
(import spork/http)
(import ulid)

(import ./db)
(use ../src/server)
(import ../src :as datastar)

# These two contain the HTTP handlers.
(import ./pages)
(import ./sse)

(def redka-client (redka/make-client))
(db/seed redka-client)

(defn- req-to-patt [req]
  {:route (string/split "/" (string/triml (get req :route) "/"))
   :method (get req :method)})

(defn- session-cookie-mw
  [nextmw]
  (def cookie-name "cart-id")
  (fn session-cookie-mw [req]
    (if (get-in req [:cookies cookie-name] false)
      (do
        (nextmw req))
      (do
        (def cart-id (ulid/make))
        (def new-cookies (table ;(kvs (get req :cookies @{}))))
        (put new-cookies cookie-name cart-id)
        (put req :cookies new-cookies)
        (def ret (table ;(kvs (nextmw req))))
        (def new-headers (table ;(kvs (get ret :headers @{}))))
        # @TODO make these configurable
        (put new-headers :set-cookie (string/format "%s=%s; HttpOnly; SameSite=Lax; Path=/; Domain=localhost; Max-Age=86400" cookie-name cart-id))
        (put ret :headers new-headers)
        ret))))

(server (http/cookies (session-cookie-mw (datastar/middleware (fn [req]
                                                                (pat/match (req-to-patt req)
                                                                           {:route [""] :method "GET"} (pages/index req)
                                                                           {:route ["about"] :method "GET"} (pages/about req)
                                                                           {:route ["cart"] :method "GET"} (pages/cart req)
                                                                           {:route ["items" id "add-to-cart"] :method "POST"} (sse/add-to-cart req id)
                                                                           {:route ["items"] :method "POST"} (sse/item-search req redka-client)
                                                                           _ {:status 404}))))))
