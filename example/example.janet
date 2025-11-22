(import pat)
(import spork/http)
(import spork/htmlgen)

(import ../src :as datastar)
(use ../src/server)
(import ../src/attributes)
(import ../src/actions)
(import ../src/events)

(use module)

(def state {:items [{:name "Pencil"} {:name "Eraser"} {:name "Ruler"}]
            :users [{:name "Admin"} {:name "Rok"}]
            :sessions []
            :carts []
            :orders []})

(defmodule- components
  (defn heading [summary & breadcrumbs]
    [:hgroup
     [:h2
      [:nav {:aria-label "breadcrumb" :style "--pico-nav-breadcrumb-divider: '|';"}
       [:ul ;(map (fn [x] [:li (case (type x) :struct [:a {:href (get x :href)} (get x :txt)] (string x))]) breadcrumbs)]]] [:p summary]])
  (defn article [& content] [:article ;content])
  (defn catalogue [items]
    [:div {:class "row-fluid"}
     [:article {:class "col-12 col-md-4"}
      [:fieldset
       [:label "Filter by" [:select [:option "Name"]]]
       [:label "Filter" [:input {:type "text" :placeholder "Filter"}]]
       [:label "Order by" [:select [:option "Name"]]]]]
     [:div {:class "col-12 col-md-8"}
      ;(map (fn [i] [:article (get i :name)]) items)]]))

(defn primary-layout [& content]
  (htmlgen/html
    [:html {:lang "en"}
     [:head
      [:meta {:charset "utf-8"}]
      [:meta {:name "viewport" :content "width=device-width, initial-scale=1"}]
      [:meta {:name "color-scheme" :content "light dark"}]
      [:link {:rel "stylesheet" :href "https://cdn.jsdelivr.net/npm/@yohns/picocss@2.2.9/css/pico.azure.min.css"}]
      [:script {:type "module" :src "https://cdn.jsdelivr.net/gh/starfederation/datastar@1.0.0-beta.11/bundles/datastar.js"}]
      [:title "Office Shop"]]
     [:body (struct :class "container" ;(attributes/signals {:search ""}))
      [:header
       [:nav
        [:ul [:li [:a {:href "/items"} [:strong "Office Shop"]]]]
        [:ul
         [:li [:a {:href "/about"} "About"]]
         [:li [:a {:href "/auth/sign-in" :role "button"} "Sign in"]]]]]
      [:main
       ;content]]]))

(defn- req-to-patt [req]
  {:route (string/split "/" (string/triml (get req :route) "/"))
   :method (get req :method)})

(defmodule- handlers
  (defn items []
    {:status 200 :body (primary-layout (components/heading "Below you can find the items that we currently have in stock." "Items") (components/catalogue (get state :items)))})
  (defn item [id] {:status 200 :body (primary-layout (components/heading "Below you can find the items that we currently have in stock." {:href "/items" :txt "Items"} id) (components/article))}))

(server
  (http/cookies
    (datastar/middleware
      (fn [req]
        (pat/match
          (req-to-patt req)
          {:route [""] :method "GET"} {:status 307 :headers {:location "/items"}}
          {:route ["items"] :method "GET"} (handlers/items)
          {:route ["items" id] :method "GET"} (handlers/item id)

          {:route ["about"] :method "GET"} {:status 200 :body (primary-layout (components/heading "Hello" "About") (components/article "Hello"))}
          {:route ["auth" "sign-in"] :method "GET"} {:status 200 :body (primary-layout (components/heading "Provide your credentials to sign in to your account." "Sign in") (components/article))}

          _ {:status 404})))))
