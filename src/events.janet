(import spork/json)

# HELPERS

(defn- encode-obj [obj]
  (case (type obj)
    :struct (string (json/encode obj))
    :table (string (json/encode obj))
    :string obj
    "{}"))

# EVENT TYPES

(defn merge-fragments [html &keys options]
  (def lines @[])
  (array/push lines "event: datastar-merge-fragments")
  (eachp [k v] options (do
                         (array/push lines (string/format "data: %s %s" k v))))
  # @TODO add support for multiple fragment lines
  (array/push lines (string/format "data: fragments %s" html))
  (string (string/join lines "\n") "\n\n"))

(defn merge-signals [signals &opt if-missing]
  (default if-missing false)
  (def lines ["event: datastar-merge-signals"
              (string/format "data: onlyIfMissing %V" if-missing)
              (string/format "data: signals %s" (encode-obj signals))])
  (string (string/join lines "\n") "\n\n"))

(defn remove-fragments [selector]
  (def lines @["event: datastar-remove-fragments"])
  (array/push lines (string/format "data: selector %s" selector))
  (string (string/join lines "\n") "\n\n"))

(defn remove-signals [paths]
  (def lines @["event: datastar-remove-signals"])
  (each p paths (array/push lines (string/format "data: paths %s" p)))
  (string (string/join lines "\n") "\n\n"))

(defn execute-script [attributes script-lines &opt auto-remove]
  (default auto-remove false)
  (def lines @["event: datastar-execute-script"
               (string/format "data: autoRemove %V" auto-remove)])
  (eachp [k v] attributes
    (array/push lines (string/format "data: attributes %s %V" k v)))
  (each l script-lines (array/push lines (string/format "data: script %s" l)))
  (string (string/join lines "\n") "\n\n"))
