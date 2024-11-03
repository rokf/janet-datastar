(import spork/htmlgen)
(import ../src/events)
(import ./components)
(import ./db)
(import ../src :as datastar)

(defn item-search [req redka-client]
  (def events @[])
  (if (not (string/has-suffix? "/" (get-in req [:headers "referer"]))) (array/push events (events/redirect "/"))
    (if (= "" (get-in req [:datastar :search] ""))
      (do (array/push events
                      (events/fragment
                        (htmlgen/html components/default-header) :selector "#item-header-group" :merge :outer)
                      (events/fragment
                        (htmlgen/html [:div {:id :results} ;(components/item-list (db/items redka-client nil))]) :selector "#results" :merge :outer)))
      (do
        (def items (components/item-list (db/items redka-client (get-in req [:datastar :search]))))
        (if (empty? items)
          (array/push events
                      (events/fragment (htmlgen/html components/no-result-header) :selector "#item-header-group" :merge :outer)
                      (events/fragment (htmlgen/html [:div]) :selector "#results" :merge :inner))
          (array/push events
                      (events/fragment (htmlgen/html components/result-header) :selector "#item-header-group" :merge :outer)
                      (events/fragment (htmlgen/html [:div {:id :results} ;items]) :selector "#results" :merge :outer))))))
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
