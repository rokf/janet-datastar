(import spork/json)

(defn- encode-obj [obj]
  (case (type obj)
    :struct (string (json/encode obj))
    :table (string (json/encode obj))
    :string obj
    "{}"))

(defmacro- make-request-action [method]
  ~(def ,method (fn [url &opt options]
                  (default options {})
                  (string/format "@%s('%s', %s)" ',method url (encode-obj options)))))

(make-request-action get)

(make-request-action post)

(make-request-action put)

(make-request-action patch)

(make-request-action delete)

(defn peek [sig]
  (string/format "@peek(() => $%s)" sig))

(defn set-all [val fil]
  (string/format "@setAll('%s', %s)" val fil))

(defn toggle-all [fil]
  (string/format "@toggleAll('%s')" fil))

# PRO actions

(defn clipboard [t &opt b64]
  (default b64 false)
  (string/format "@clipboard('%s', %V)" t b64))


(defn fit [v old-min old-max new-min new-max &opt should-clamp should-round]
  (default should-clamp false)
  (default should-round false)
  (string/format "@fit(%d, %d, %d, %d, %d, %V, %V)" v old-min old-max new-min new-max should-clamp should-round))
