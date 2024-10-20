(declare-project
  :name "janet-datastar"
  :author "Rok Fajfar <hi@rokf.dev>"
  :description "A Janet utility library for Datastar"
  :license "MIT"
  :version "0.0.1"
  :url "https://github.com/rokf/janet-datastar"
  :repo "git+https://github.com/rokf/janet-datastar"
  :dependencies ["spork"])

(declare-source
  :prefix "datastar"
  :source ["src/attributes.janet"
           "src/actions.janet"
           "src/events.janet"])
