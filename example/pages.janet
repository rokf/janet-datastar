(import ./layouts)
(import ./components)
(import ../src/attributes)
(import ../src/actions)
(import ./sse)

(defn about [req]
  {:status 200 :body (layouts/default
                       [:h1 "About"] [:p (struct ;(attributes/scroll-into-view)) "This is a store example built around Datastar."])})

(defn cart [req]
  {:status 200 :body (layouts/default components/cart-header (components/cart-table))})

(defn items [req redka-client]
  (if (= (get-in req [:headers "accept"] "text/html") "text/event-stream")
    (sse/item-search req redka-client)
    {:status 200
     :body (layouts/default
             components/default-header
             [:div (struct
                     :id :results
                     ;(attributes/on :load (actions/get "/items")))])
     :headers {:content-type "text/html"}}))
