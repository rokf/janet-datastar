(defmacro- make-request-action [method]
  ~(def ,method (fn [& args]
                  (string/format "$$%s('%s')" ',method (string/join args "/")))))

(make-request-action get)

(make-request-action post)

(make-request-action put)

(make-request-action patch)

(make-request-action delete)

(defn is-fetching [css-selector]
  (string/format "$$isFetching('%s')" css-selector))

(defn set-all [regexp val]
  (string/format "$$setAll('%s', %s)" regexp val))

(defn toggle-all [regexp]
  (string/format "$$toggleAll('%s')" regexp))

(defn clipboard [txt]
  (string/format "$$clipboard('%s')" txt))

(defn fit [v old-min old-max new-min new-max]
  (string/format "$$fit(%d, %d, %d, %d, %d)" v old-min old-max new-min new-max))

(defn fit-int [v old-min old-max new-min new-max]
  (string/format "$$fitInt(%d, %d, %d, %d, %d)" v old-min old-max new-min new-max))

(defn clamp-fit [v old-min old-max new-min new-max]
  (string/format "$$clampFit(%d, %d, %d, %d, %d)" v old-min old-max new-min new-max))

(defn clamp-fit-int [v old-min old-max new-min new-max]
  (string/format "$$clampFitInt(%d, %d, %d, %d, %d)" v old-min old-max new-min new-max))
