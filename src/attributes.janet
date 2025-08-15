(import spork/json)

(defn- encode-modifier [modifier]
  (case (type modifier)
    :tuple (string/join modifier ".")
    :array (string/join modifier ".")
    (string modifier)))

# @TODO add support for Datastar expressions
(defn- encode-obj [obj]
  (case (type obj)
    :struct (string (json/encode obj))
    :table (string (json/encode obj))
    :string obj
    "{}"))

(defn signals [obj & modifiers]
  [(string/join ["data-signals" ;(map encode-modifier modifiers)] "__") (encode-obj obj)])

(defn ref [sig & modifiers]
  [(string/join ["data-ref" ;(map encode-modifier modifiers)] "__") sig])

(defn style [obj]
  ["data-style" (encode-obj obj)])

(defn attr [obj]
  ["data-attr" (encode-obj obj)])

(defn bind [sig & modifiers]
  [(string/join ["data-bind" ;(map encode-modifier modifiers)] "__") sig])

(defn class [obj & modifiers]
  [(string/join ["data-class" ;(map encode-modifier modifiers)] "__") obj])

(defn on [event expr & modifiers]
  [(string/join [(string "data-on-" event) ;(map encode-modifier modifiers)] "__") expr])

(defn computed [sig expr & modifiers]
  [(string/join [(string "data-computed-" sig) ;(map encode-modifier modifiers)] "__") expr])

(defn text [expr]
  ["data-text" expr])

(defn effect [expr]
  ["data-effect" expr])

(defn on-intersect [expr & modifiers]
  [(string/join ["data-on-intersect" ;(map encode-modifier modifiers)] "__") expr])

(defn on-interval [expr & modifiers]
  [(string/join ["data-on-interval" ;(map encode-modifier modifiers)] "__") expr])

(defn on-load [expr & modifiers]
  [(string/join ["data-on-load" ;(map encode-modifier modifiers)] "__") expr])

(defn on-signal-patch [expr & modifiers]
  [(string/join ["data-on-signal-patch" ;(map encode-modifier modifiers)] "__") expr])

(defn on-signal-patch-filter [obj]
  ["data-on-signal-patch-filter" (encode-obj obj)])

(defn preserve-attr [attributes]
  ["data-preserve-attr" (string/join attributes " ")])

(defn show [expr]
  ["data-show" expr])

(defn indicator [sig & modifiers]
  [(string/join ["data-indicator" ;(map encode-modifier modifiers)] "__") sig])

(defn ignore [& modifiers]
  [(string/join ["data-ignore" ;(map encode-modifier modifiers)] "__") ""])

(defn ignore-morph []
  ["data-ignore-morph" ""])

(defn json-signals [obj & modifiers]
  [(string/join ["data-json-signals" ;(map encode-modifier modifiers)] "__") (encode-obj obj)])

# PRO attributes

(defn animate []
  ["data-animate"])

(defn custom-validity [expr]
  ["data-custom-validity" expr])

(defn on-raf [expr & modifiers]
  [(string/join ["data-on-raf" ;(map encode-modifier modifiers)] "__") expr])

(defn on-resize [expr & modifiers]
  [(string/join ["data-on-raf" ;(map encode-modifier modifiers)] "__") expr])

(defn replace-url [expr]
  ["data-replace-url" (string "`" expr "`")])

(defn scroll-into-view [& modifiers]
  [(string/join ["data-scroll-into-view" ;(map encode-modifier modifiers)] "__") ""])

(defn- list-to-string [l]
  (case (type l)
    :tuple (string/join l " ")
    :array (string/join l " ")
    (string l)))

(defn persist [&opt key obj & modifiers]
  (default key "datastar")
  (default obj "")
  [(string/join [(string "data-persist-" key) ;(map encode-modifier modifiers)] "__") (encode-obj obj)])


(defn query-string [&opt obj & modifiers]
  (default obj "")
  [(string/join ["data-query-string" ;(map encode-modifier modifiers)] "__") (encode-obj obj)])

(defn view-transition [expr]
  ["data-view-transition" expr])
