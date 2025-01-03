(import spork/json)

# HELPERS

(defn- encode-obj [obj]
  (case (type obj)
    :struct (string (json/encode obj))
    :table (string (json/encode obj))
    :string obj
    "{}"))


# BACKEND PLUGINS

(defmacro- make-request-action [method]
  ~(def ,method (fn [url &opt options]
                  (default options {})
                  (string/format "@%s('%s', %s)" ',method url (encode-obj options)))))

(make-request-action get)

(make-request-action post)

(make-request-action put)

(make-request-action patch)

(make-request-action delete)

# LOGIC PLUGINS

(defn set-all [regexp val]
  (string/format "@setAll('%s', %s)" regexp val))

(defn toggle-all [regexp]
  (string/format "@toggleAll('%s')" regexp))

(defn fit [v old-min old-max new-min new-max &opt should-clamp should-round]
  (default should-clamp false)
  (default should-round false)
  (string/format "@fit(%d, %d, %d, %d, %d, %V, %V)" v old-min old-max new-min new-max should-clamp should-round))
