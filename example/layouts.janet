(import spork/htmlgen)
(import ../src/attributes)
(import ../src/actions)

(defn default [& content]
  (htmlgen/html
    [:html {:lang "en"}
     [:head
      [:meta {:charset "utf-8"}]
      [:meta {:name "viewport" :content "width=device-width, initial-scale=1"}]
      [:meta {:name "color-scheme" :content "light dark"}]
      [:link {:rel "stylesheet" :href "https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css"}]
      [:script {:type "module" :src "https://cdn.jsdelivr.net/npm/@sudodevnull/datastar@0.19.9/dist/datastar.min.js"}]
      [:title "office.shop"]]
     [:body (struct :class "container" ;(attributes/store {:search ""}))
      [:header
       [:nav
        [:ul [:li [:a {:href "/"} [:strong "office.shop"]]]]
        [:ul [:li [:input
                   (struct
                     :type "search"
                     :placeholder "I'm looking for..."
                     ;(attributes/model :search)
                     ;(attributes/on :input (actions/post "/items") "debounce_500ms"))]]]
        [:ul
         [:li [:a {:href "/about"} "About"]]
         [:li [:a {:href "/cart"} "Cart (0)"]]]]]
      [:main
       ;content]]]))
