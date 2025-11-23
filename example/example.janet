(import pat)
(import spork/http)
(import spork/htmlgen)

(import ../src :as datastar)
(import ../src/attributes)
(import ../src/actions)
(import ../src/events)

(use module)

(def- events @[{:title "A" :created-at (os/time)}])

(defmodule- components
  (defn heading [summary & breadcrumbs]
    [:hgroup
     [:h2
      [:nav {:aria-label "breadcrumb" :style "--pico-nav-breadcrumb-divider: '|';"}
       [:ul ;(map (fn [x] [:li (case (type x) :struct [:a {:href (get x :href)} (get x :txt)] (string x))]) breadcrumbs)]]] [:p summary]])
  (defn article [& content] [:article ;content]))

(defn primary-layout [& content]
  (htmlgen/html
    [:html {:lang "en"}
     [:head
      [:meta {:charset "utf-8"}]
      [:meta {:name "viewport" :content "width=device-width, initial-scale=1"}]
      [:meta {:name "color-scheme" :content "light dark"}]
      [:link {:rel "stylesheet" :href "https://cdn.jsdelivr.net/npm/@picocss/pico@2/css/pico.min.css"}]
      [:script {:type "module" :src "https://cdn.jsdelivr.net/gh/starfederation/datastar@1.0.0-RC.6/bundles/datastar.js"}]
      [:title "Example"]]
     [:body {:class "container"}
      [:header
       [:nav
        [:ul [:li [:a {:href "/"} [:strong "Example"]]]]
        [:ul
         [:li [:a {:href "/events"} "Events"]]]]]
      [:main
       ;content]]]))

(defn- req-to-patt [req]
  {:route (string/split "/" (string/triml (get req :route) "/"))
   :method (get req :method)})

(defn- event-table [events]
  [:tbody {:id "event-table"}
   ;(map (fn [e]
           [:tr
            [:td (get e :title)]
            [:td (get e :created-at)]
            [:td [:button {:class "secondary"} "x"]]]) events)])

(http/server
  (http/cookies
    (datastar/middleware
      (fn [req]
        (pat/match
          (req-to-patt req)
          {:route [""] :method "GET"} {:status 307 :headers {:location "/events"}}
          {:route ["event-stream"] :method "GET"} (let
                                                    [c (get req :connection)]
                                                    (http/send-response c {:headers datastar/headers})
                                                    (for i 0 10
                                                      (ev/sleep 1)
                                                      (ev/write c (events/patch-elements (htmlgen/html (event-table events))))
                                                      (array/push events {:title "X" :created-at (os/time)}))
                                                    {:status 204})
          {:route ["events"] :method "GET"} {:status 200 :body (primary-layout
                                                                 (components/heading "See events as they happen." "Events")
                                                                 (components/article [:table (struct ;(attributes/init (actions/get "/event-stream"))) [:thead [:tr [:th "Title"] [:th "Created at"] [:th "Actions"]]] (event-table events)]))}

          _ {:status 404})))))
