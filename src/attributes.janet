(import spork/json)

# HELPERS

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

# CORE PLUGINS

(defn signals [obj & modifiers]
  [(string/join ["data-signals" ;(map encode-modifier modifiers)] "__") (encode-obj obj)])

(defn computed [key expr]
  [(string "data-computed-" key) expr])

(defn ref [r]
  [:data-ref r])

# DOM PLUGINS

(defn attr [obj]
  ["data-attr" (encode-obj obj)])

(defn bind [signal]
  ["data-bind" signal])

(defn class [obj]
  ["data-class" (encode-obj obj)])

(defn on [event expr & modifiers]
  [(string/join [(string "data-on-" event) ;(map encode-modifier modifiers)] "__") expr])

(defn persist [&opt key val & modifiers]
  (default key "datastar")
  (default val "")
  [(string/join [(string "data-persist-" key) ;(map encode-modifier modifiers)] "__") val])

(defn replace-url [expr]
  ["data-replace-url" expr])

(defn text [expr]
  ["data-text" expr])

# BROWSER PLUGINS

(defn custom-validity [expr]
  ["data-custom-validity" expr])

(defn intersects [expr & modifiers]
  [(string/join [:data-intersects ;(map encode-modifier modifiers)] "__") expr])

(defn scroll-into-view [& modifiers]
  [(string/join ["data-scroll-into-view" ;(map encode-modifier modifiers)] "__") ""])

(defn show [expr]
  ["data-show" expr])

(defn view-transition [name]
  ["data-view-transition" name])

# BACKEND PLUGINS

(defn indicator [sig]
  ["data-indicator" (string "$" sig)])

# IGNORING ELEMENTS

(defn ignore []
  [:data-star-ignore ""])
