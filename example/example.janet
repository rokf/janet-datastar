(import ../src/attributes)
(import ../src/actions)
(import ../src/events)
(import ../src :as datastar)
(import pat)
(import spork/htmlgen)
(import redka)

(use ../src/server)

(defn- req-to-patt [req]
  {:route (string/split "/" (string/triml (get req :route) "/"))
   :method (get req :method)})

(defn- layout [& content]
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
                   (struct :type "search" :placeholder "I'm looking for..." ;(attributes/model :search) ;(attributes/on :input (actions/post "/items") "debounce_500ms"))]]]
        [:ul
         [:li [:a {:href "/about"} "About"]]
         [:li [:a {:href "/cart"} "Cart (0)"]]]]]
      [:main
       ;content]]]))

(defn- item-card [id src name description price stock]
  [:article {:id id}
   [:div {:class "grid"}
    [:img {:src src :height "200" :width "200"}]
    [:div
     [:hgroup [:h4 {:data-tooltip (string/format "%s left in stock." stock)} name (string/format " (%s)" stock)] [:p description]]
     [:p [:strong (string "$" price)]]
     [:fieldset {:role "group"}
      [:input {:type "number" :value 1 :min 1}]
      [:button
       (struct ;(attributes/on :click (actions/post "/items" "1" "add-to-cart")))
       "Add"]]]]])

(defn- make-pairs [acc items]
  (match items
    [l r & rest] (make-pairs [;acc [l r]] rest)
    [l] (make-pairs [;acc [l [:div]]] [])
    [] acc))

(defn- seed [db]
  (pp "Seeding Redka with dummy data")
  (def items [{:image "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXBlbmNpbCI+PHBhdGggZD0iTTIxLjE3NCA2LjgxMmExIDEgMCAwIDAtMy45ODYtMy45ODdMMy44NDIgMTYuMTc0YTIgMiAwIDAgMC0uNS44M2wtMS4zMjEgNC4zNTJhLjUuNSAwIDAgMCAuNjIzLjYyMmw0LjM1My0xLjMyYTIgMiAwIDAgMCAuODMtLjQ5N3oiLz48cGF0aCBkPSJtMTUgNSA0IDQiLz48L3N2Zz4="
               :name "Pencil"
               :description "Pointy!"
               :price 2.52
               :stock 50}
              {:image "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLWVyYXNlciI+PHBhdGggZD0ibTcgMjEtNC4zLTQuM2MtMS0xLTEtMi41IDAtMy40bDkuNi05LjZjMS0xIDIuNS0xIDMuNCAwbDUuNiA1LjZjMSAxIDEgMi41IDAgMy40TDEzIDIxIi8+PHBhdGggZD0iTTIyIDIxSDciLz48cGF0aCBkPSJtNSAxMSA5IDkiLz48L3N2Zz4="
               :name "Eraser"
               :description "Removes mistakes."
               :price 4.39
               :stock 5}
              {:image "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSIyNCIgaGVpZ2h0PSIyNCIgdmlld0JveD0iMCAwIDI0IDI0IiBmaWxsPSJub25lIiBzdHJva2U9ImN1cnJlbnRDb2xvciIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiIGNsYXNzPSJsdWNpZGUgbHVjaWRlLXBpbiI+PHBhdGggZD0iTTEyIDE3djUiLz48cGF0aCBkPSJNOSAxMC43NmEyIDIgMCAwIDEtMS4xMSAxLjc5bC0xLjc4LjlBMiAyIDAgMCAwIDUgMTUuMjRWMTZhMSAxIDAgMCAwIDEgMWgxMmExIDEgMCAwIDAgMS0xdi0uNzZhMiAyIDAgMCAwLTEuMTEtMS43OWwtMS43OC0uOUEyIDIgMCAwIDEgMTUgMTAuNzZWN2ExIDEgMCAwIDEgMS0xIDIgMiAwIDAgMCAwLTRIOGEyIDIgMCAwIDAgMCA0IDEgMSAwIDAgMSAxIDF6Ii8+PC9zdmc+"
               :name "Pin"
               :description "Pointy..."
               :price 0.25
               :stock 120}])
  (redka/flushdb db)
  (each item items (do
                     (redka/hset db (string/format "items:%s" (string/replace " " "_" (string/ascii-lower (get item :name))))
                                 :image (get item :image)
                                 :name (get item :name)
                                 :description (get item :description)
                                 :price (get item :price)
                                 :stock (get item :stock)))))

(def db (redka/make-client))
(seed db)

(defn- make-header [title description]
  [:hgroup {:id "item-header-group"} [:h1 {:id "item-header"} title] [:p description]])

(def- default-header (make-header "Items" "These are the items we're selling."))
(def- result-header (make-header "Results" "Were you perhaps looking for one of these items?"))
(def- no-result-header (make-header "No results" "No results found."))

(defn- item-list [&opt search]
  (default search "")
  (def items @[])
  (each id (redka/keys db (string/format "items:%s*" search)) (do
                                                                (def item (table ;(redka/hgetall db id)))
                                                                (array/push items (item-card
                                                                                    id
                                                                                    (get item "image")
                                                                                    (get item "name")
                                                                                    (get item "description")
                                                                                    (get item "price")
                                                                                    (get item "stock")))))
  (do
    (def results (map (fn [p] [:div {:class "grid"} ;p]) (make-pairs [] items)))
    (pp (length results))
    results))

(defn- index-page [req]
  {:status 200
   :body (layout default-header [:div {:id :results} ;(item-list)])
   :headers {:content-type "text/html"}})

(defn- about-page [req]
  {:status 200 :body (layout [:h1 "About"])})

(defn- cart-page [req]
  {:status 200 :body (layout [:h1 "Cart"])})

(defn- add-to-cart [req id]
  (pp (redka/ping db))
  (def sse-chan (ev/chan))
  (ev/spawn (do
              (ev/give sse-chan (events/console :log "Testing"))
              (ev/sleep 1)
              (ev/give sse-chan (events/console :debug "Debugging"))
              (ev/sleep 1)
              (ev/give sse-chan (events/console :info "Closing"))
              (ev/sleep 1)
              (ev/chan-close sse-chan)))
  {:headers {:cache-control "no-cache" :content-type "text/event-stream" :connection "keep-alive"}
   :body sse-chan})

(defn- item-search [req]
  (def events @[])
  (if (= "" (get-in req [:datastar :search] ""))
    (do (array/push events
                    (events/fragment (htmlgen/html default-header) :selector "#item-header-group" :merge :outer)
                    (events/fragment (htmlgen/html [:div {:id :results} ;(item-list)]) :selector "#results" :merge :outer)))
    (do
      (pp (get-in req [:datastar :search]))
      (def items (item-list (get-in req [:datastar :search])))
      (if (empty? items)
        (array/push events
                    (events/fragment (htmlgen/html no-result-header) :selector "#item-header-group" :merge :outer)
                    (events/fragment (htmlgen/html [:div]) :selector "#results" :merge :inner))
        (array/push events
                    (events/fragment (htmlgen/html result-header) :selector "#item-header-group" :merge :outer)
                    (events/fragment (htmlgen/html [:div {:id :results} ;items]) :selector "#results" :merge :outer)))))
  {:headers datastar/headers
   :body events})

(server (datastar/middleware (fn [req]
                               (pat/match (req-to-patt req)
                                          {:route [""] :method "GET"} (index-page req)
                                          {:route ["about"] :method "GET"} (about-page req)
                                          {:route ["cart"] :method "GET"} (cart-page req)
                                          {:route ["items" id "add-to-cart"] :method "POST"} (add-to-cart req id)
                                          {:route ["items"] :method "POST"} (item-search req)
                                          _ {:status 400}))))
