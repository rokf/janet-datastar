(import spork/json)

# check if the JSON encoder actually works here or not
(defn store [obj & modifiers]
  [(string/join [:data-store ;(map string modifiers)] ".") (string (json/encode obj))])

(defn ref [r]
  [:data-ref r])

(defn bind [attr expr]
  [(string "data-bind-" attr) expr])

(defn model [signal-name]
  ["data-model" signal-name])

(defn text [expr]
  ["data-text" expr])

(defn on [event expr & modifiers]
  [(string/join [(string :data-on- event) ;(map string modifiers)] ".") expr])

(defn fetch-indicator [css-selector]
  [:data-fetch-indicator css-selector])

(defn show [expr & modifiers]
  [(string/join [:data-show ;(map string modifiers)] ".") expr])

(defn intersect [expr & modifiers]
  [(string/join [:data-intersect ;(map string modifiers)] ".") expr])

(defn teleport [css-selector & modifiers]
  [(string/join [:data-teleport ;(map string modifiers)] ".") css-selector])

# will this work?
(defn scroll-into-view [& modifiers]
  [(string/join [:data-scroll-into-view ;(map string modifiers)] ".") :true])

(defn view-transition [name]
  ["data-view-transition" name])
