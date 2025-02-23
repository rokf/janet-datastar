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
      [:script {:type "module" :src "https://cdn.jsdelivr.net/gh/starfederation/datastar@v1.0.0-beta.1/bundles/datastar.js"}]
      [:title "office.shop"]]
     [:body (struct :class "container" ;(attributes/signals {:search ""}))
      [:header
       [:nav
        [:ul [:li [:a {:href "/items"} [:strong "office.shop"]]]]
        [:ul [:li [:input
                   (struct
                     :type "search"
                     :placeholder "I'm looking for..."
                     ;(attributes/bind :search)
                     ;(attributes/on :input (actions/get "/items") [:debounce "500ms"]))]]]
        [:ul
         [:li [:a {:href "/about"} "About"]]
         [:li [:a {:href "/cart"} "Cart (0)"]]]]]
      [:main {:id "page-content"}
       ;content]]]))
