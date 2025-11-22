(import spork/json)

(defn- encode-obj [obj]
  (case (type obj)
    :struct (string (json/encode obj))
    :table (string (json/encode obj))
    :string obj
    "{}"))

(defn patch-elements [html &keys options]
  (def lines @[])
  (array/push lines "event: datastar-patch-elements")
  (eachp [k v] options
    (do
      (array/push lines (string/format "data: %s %s" k v))))
  (array/push lines ;(case (type html)
                       :tuple (map |(string/format "data: elements %s" $) html)
                       :array (map |(string/format "data: elements %s" $) html)
                       [(string/format "data: elements %s" html)]))

  (string (string/join lines "\n") "\n\n"))

(defn patch-signals [signals &opt if-missing]
  (default if-missing false)
  (def lines ["event: datastar-patch-signals"
              (string/format "data: onlyIfMissing %V" if-missing)
              (string/format "data: signals %s" (encode-obj signals))])
  (string (string/join lines "\n") "\n\n"))
