(defn rocket [name]
  [(string "data-rocket:" name) ""])

(defn props [name codec]
  [(string "data-props:" name) codec])

(defn static []
  ["data-static" ""])

(defn import-esm [name link]
  [(string "data-import-esm:" name) link])

(defn import-iife [name link]
  [(string "data-import-iife:" name) link])

(defn shadow-open []
  ["data-shadow-open" ""])

(defn shadow-closed []
  ["data-shadow-open" ""])

(defn if [expr]
  ["data-if" expr])

(defn else-if [expr]
  ["data-else-if" expr])

(defn else []
  ["data-else" ""])

(defn for [expr]
  ["data-for" expr])

# @TODO consider adding helpers for writing codecs (validation, transformation)

