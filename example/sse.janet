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
  (if (not (string/has-suffix? "/" referer-header)) (array/push events (events/redirect "/"))
    (if (= "" search-term)
      (do (array/push events
                      (events/fragment
                        (htmlgen/html components/default-header) :selector "#item-header-group" :merge :outer)
                      (events/fragment
                        (htmlgen/html [:div {:id :results} ;(components/item-list items)]) :selector "#results" :merge :outer)))
      (do
        (if (empty? items)
          (array/push events
                      (events/fragment
                        (htmlgen/html components/no-result-header)
                        :selector "#item-header-group"
                        :merge :outer)
                      (events/fragment
                        (htmlgen/html [:div])
                        :selector "#results"
                        :merge :inner))
          (array/push events
                      (events/fragment
                        (htmlgen/html components/result-header)
                        :selector "#item-header-group"
                        :merge :outer)
                      (events/fragment
                        (htmlgen/html [:div {:id :results} ;(components/item-list items)])
                        :selector "#results"
                        :merge :outer))))))
  {:headers datastar/headers
   :body events})

(defn add-to-cart [req id]
  (def sse-chan (ev/chan))
  (ev/spawn (do
              (ev/give sse-chan (events/console :log "Testing"))
              (ev/sleep 1)
              (ev/give sse-chan (events/console :debug "Debugging"))
              (ev/sleep 1)
              (ev/give sse-chan (events/console :info "Closing"))
              (ev/sleep 1)
              (ev/chan-close sse-chan)))
  {:headers datastar/headers
   :body sse-chan})
