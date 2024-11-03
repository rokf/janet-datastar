(import pat)
(import redka)

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

(server (datastar/middleware (fn [req]
                               (pat/match (req-to-patt req)
                                          {:route [""] :method "GET"} (pages/index req)
                                          {:route ["about"] :method "GET"} (pages/about req)
                                          {:route ["cart"] :method "GET"} (pages/cart req)
                                          {:route ["items" id "add-to-cart"] :method "POST"} (sse/add-to-cart req id)
                                          {:route ["items"] :method "POST"} (sse/item-search req redka-client)
                                          _ {:status 404}))))
