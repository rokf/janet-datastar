(import spork/json)

(defn- encode-modifier [modifier]
  (case (type modifier)
    :tuple (string/join modifier ".")
    :array (string/join modifier ".")
    (string modifier)))

(defn- encode-obj [obj]
  (case (type obj)
    :struct (string (json/encode obj))
    :table (string (json/encode obj))
    :string obj
    "{}"))

(defn signals [obj &opt s & modifiers]
  [(string/join [(string "data-signals" (if s (string ":" s))) ;(map encode-modifier modifiers)] "__") (encode-obj obj)])

(defn ref [sig & modifiers]
  [(string/join ["data-ref" ;(map encode-modifier modifiers)] "__") sig])

(defn style [obj &opt s]
  [(string "data-style" (if s (string ":" s))) (encode-obj obj)])

(defn attr [obj &opt a]
  [(string "data-attr" (if a (string ":" a))) (encode-obj obj)])

(defn bind [sig & modifiers]
  [(string/join ["data-bind" ;(map encode-modifier modifiers)] "__") sig])

(defn class [obj &opt c & modifiers]
  [(string/join [(string "data-class" (if c (string ":" c))) ;(map encode-modifier modifiers)] "__") (encode-obj obj)])

(defn on [event expr & modifiers]
  [(string/join [(string "data-on:" event) ;(map encode-modifier modifiers)] "__") expr])

(defn computed [obj &opt s & modifiers]
  [(string/join [(string "data-computed" (if s (string ":" s))) ;(map encode-modifier modifiers)] "__") (encode-obj obj)])

(defn text [expr]
  ["data-text" expr])

(defn effect [expr]
  ["data-effect" expr])

(defn on-intersect [expr & modifiers]
  [(string/join ["data-on-intersect" ;(map encode-modifier modifiers)] "__") expr])

(defn on-interval [expr & modifiers]
  [(string/join ["data-on-interval" ;(map encode-modifier modifiers)] "__") expr])

(defn init [expr & modifiers]
  [(string/join ["data-init" ;(map encode-modifier modifiers)] "__") expr])

(defn on-signal-patch [expr & modifiers]
  [(string/join ["data-on-signal-patch" ;(map encode-modifier modifiers)] "__") expr])

(defn on-signal-patch-filter [obj]
  ["data-on-signal-patch-filter" (encode-obj obj)])

(defn preserve-attr [& attributes]
  ["data-preserve-attr" (string/join attributes " ")])

(defn show [expr]
  ["data-show" expr])

(defn indicator [sig & modifiers]
  [(string/join ["data-indicator" ;(map encode-modifier modifiers)] "__") sig])

(defn ignore [& modifiers]
  [(string/join ["data-ignore" ;(map encode-modifier modifiers)] "__") ""])

(defn ignore-morph []
  ["data-ignore-morph" ""])


(defn json-signals [&opt obj & modifiers]
  (default obj "")
  [(string/join ["data-json-signals" ;(map encode-modifier modifiers)] "__") (encode-obj obj)])

# PRO attributes

(defn animate []
  ["data-animate"])

(defn custom-validity [expr]
  ["data-custom-validity" expr])

(defn on-raf [expr & modifiers]
  [(string/join ["data-on-raf" ;(map encode-modifier modifiers)] "__") expr])

(defn on-resize [expr & modifiers]
  [(string/join ["data-on-resize" ;(map encode-modifier modifiers)] "__") expr])

(defn replace-url [expr]
  ["data-replace-url" (string "`" expr "`")])

(defn scroll-into-view [& modifiers]
  [(string/join ["data-scroll-into-view" ;(map encode-modifier modifiers)] "__") ""])

(defn- list-to-string [l]
  (case (type l)
    :tuple (string/join l " ")
    :array (string/join l " ")
    (string l)))

(defn persist [&opt obj key & modifiers]
  (default key "datastar")
  (default obj "")
  [(string/join [(string "data-persist:" key) ;(map encode-modifier modifiers)] "__") (encode-obj obj)])


(defn query-string [&opt obj & modifiers]
  (default obj "")
  [(string/join ["data-query-string" ;(map encode-modifier modifiers)] "__") (encode-obj obj)])

(defn view-transition [expr]
  ["data-view-transition" (string expr)])
