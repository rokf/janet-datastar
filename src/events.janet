(import spork/json)

(defn fragment [html &keys options]
  (def lines @[])
  (array/push lines "event: datastar-fragment")
  (eachp [k v] options (do
                         (array/push lines (string/format "data: %s %s" k v))))
  (array/push lines (string/format "data: fragment %s" html))
  (string (string/join lines "\n") "\n\n"))

(defn signal [ifmissing store]
  (def lines ["event: datastar-signal"
              (string/format "data: ifmissing %s" ifmissing)
              (string/format "data: store %s" (string (json/encode store)))])
  (string (string/join lines "\n") "\n\n"))

(defn delete [input]
  (def lines @["event: datastar-delete"])
  (array/push lines (case (type input)
                      :array (string/format "data: paths %s" (string/join (map string input) " "))
                      :tuple (string/format "data: paths %s" (string/join (map string input) " "))
                      :string (string/format "data: selector %s" input)
                      :keyword (string/format "data: selector %s" input)))
  (string (string/join lines "\n") "\n\n"))

(defn redirect [url]
  (def lines ["event: datastar-redirect"
              (string/format "data: url %s" url)])
  (string (string/join lines "\n") "\n\n"))

(defn console [mode msg]
  (def lines ["event: datastar-console"
              (string/format "data: %s %s" mode msg)])
  (string (string/join lines "\n") "\n\n"))
