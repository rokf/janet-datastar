(import spork/htmlgen)
(import ../src/events)
(import ./components)
(import ./db)
(import ../src :as datastar)
(import ../src/attributes)

(defn item-search [req redka-client]
  (def referer-header (get-in req [:headers "referer"]))
  (def search-term (get-in req [:datastar :search] ""))
  (def items (db/items redka-client search-term))
  (def events @[])
  (if (= "" search-term)
    (do
      (array/push events
                  (events/merge-fragments
                    (htmlgen/html
                      [:template components/default-header
                       [:div (struct ;(attributes/replace-url "'/items'") :id "results") ;(components/item-list items)]]) :selector "#page-content" :mergeMode :inner)))
    (do
      (if (empty? items)
        (array/push events
                    (events/merge-fragments
                      (htmlgen/html
                        [:template components/no-result-header
                         [:div (struct ;(attributes/replace-url "'/items'") :id "results")]]) :selector "#page-content" :mergeMode :inner))
        (array/push events
                    (events/merge-fragments
                      (htmlgen/html
                        [:template components/result-header
                         [:div (struct ;(attributes/replace-url "'/items'") :id "results") ;(components/item-list items)]]) :selector "#page-content" :mergeMode :inner)))))
  {:headers datastar/headers
   :body events})

(defn add-to-cart [req id]
  (def sse-chan (ev/chan))
  (ev/spawn (do
              (ev/sleep 1)
              (ev/chan-close sse-chan)))
  {:headers datastar/headers
   :body sse-chan})
