(defn fragment [html &keys options]
  (def lines @[])
  (array/push lines "event: datastar-fragment")
  (eachp [k v] options (do
                         (array/push (string/format "data: %s %s" k v))))
  (array/push lines (string/format "data: fragment %s" html))
  lines)

(defn signal [ifmissing store]
  ["event: datastar-signal"
   (string/format "data: ifmissing %s" ifmissing)
   (string/format "data: store %s" (string (json/encode store)))])

(defn delete [input]
  (def lines @["event: datastar-delete"])
  (case (type input)
    :array (string/format "data: paths %s" (string/join (map string input) " "))
    :tuple (string/format "data: paths %s" (string/join (map string input) " "))
    :string (string/format "data: selector %s" input)
    :keyword (string/format "data: selector %s" input))
  lines)

(defn redirect [url]
  ["event: datastar-redirect"
   (string/format "data: url %s" url)])

(defn console [mode msg]
  ["event: datastar-console"
   (string/format "data: %s %s" mode msg)])
