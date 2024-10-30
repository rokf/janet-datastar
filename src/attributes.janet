(import spork/json)

(defn store [obj & modifiers]
  [(string/join [:data-store ;(map string modifiers)] ".") (string (json/encode obj))])

(defn computed [key expr]
  [(string "data-computed-" key) expr])

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

(defn class [obj]
  ["data-class" (string (json/encode obj))])

(defn fetch-indicator [css-selector]
  [:data-fetch-indicator css-selector])

(defn header [name value]
  [(string "data-header-" (string/ascii-lower name)) value])

(defn show [expr & modifiers]
  [(string/join [:data-show ;(map string modifiers)] ".") expr])

(defn intersects [expr & modifiers]
  [(string/join [:data-intersects ;(map string modifiers)] ".") expr])

(defn teleport [css-selector & modifiers]
  [(string/join [:data-teleport ;(map string modifiers)] ".") css-selector])

# @TODO will this work?
(defn scroll-into-view [& modifiers]
  [(string/join [:data-scroll-into-view ;(map string modifiers)] ".") :true])

(defn view-transition [name]
  ["data-view-transition" name])
