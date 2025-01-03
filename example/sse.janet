(import spork/htmlgen)
(import ../src/events)
(import ./components)
(import ./db)
(import ../src :as datastar)

(defn item-search [req redka-client]
  (def referer-header (get-in req [:headers "referer"]))
  (def search-term (get-in req [:datastar :search] ""))
  (def items (db/items redka-client search-term))
  (def events @[])
  (if (= "" search-term)
    (do (array/push events
                    (events/merge-fragments
                      (htmlgen/html components/default-header) :selector "#item-header-group" :mergeMode :outer)
                    (events/merge-fragments
                      (htmlgen/html [:div {:id :results} ;(components/item-list items)]) :selector "#results" :mergeMode :outer)))
    (do
      (if (empty? items)
        (array/push events
                    (events/merge-fragments
                      (htmlgen/html components/no-result-header)
                      :selector "#item-header-group"
                      :mergeMode :outer)
                    (events/merge-fragments
                      (htmlgen/html [:div])
                      :selector "#results"
                      :mergeMode :inner))
        (array/push events
                    (events/merge-fragments
                      (htmlgen/html components/result-header)
                      :selector "#item-header-group"
                      :mergeMode :outer)
                    (events/merge-fragments
                      (htmlgen/html [:div {:id :results} ;(components/item-list items)])
                      :selector "#results"
                      :mergeMode :outer)))))
  {:headers datastar/headers
   :body events})

(defn add-to-cart [req id]
  (def sse-chan (ev/chan))
  (ev/spawn (do
              (ev/sleep 1)
              (ev/chan-close sse-chan)))
  {:headers datastar/headers
   :body sse-chan})
