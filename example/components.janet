# This module contains components that are supposed to be used together
# with html from pork/htmlgen.

(import ../src/attributes)
(import ../src/actions)

(defn- make-header [title description]
  [:hgroup {:id "item-header-group"} [:h1 {:id "item-header"} title] [:p description]])

(def default-header (make-header "Items" "These are the items we're selling."))
(def result-header (make-header "Results" "Were you perhaps looking for one of these items?"))
(def no-result-header (make-header "No results" "No results found."))
(def cart-header (make-header "Cart" "You have the following items in your cart."))

(defn item-card [item]
  [:article {:id (item :id)}
   [:div {:class "grid"}
    [:img {:src (item :image) :height "200" :width "200"}]
    [:div
     [:hgroup [:h4 {:data-tooltip (string/format "%s left in stock." (item :stock))} (item :name) (string/format " (%s)" (item :stock))] [:p (item :description)]]
     [:p [:strong (string "$" (item :price))]]
     [:fieldset {:role "group"}
      [:input {:type "number" :value 1 :min 1 :max (item :stock)}]
      [:button
       (struct ;(attributes/on :click (actions/post (string "/items" "1" "add-to-cart"))))
       "Add"]]]]])

(defn- make-pairs [acc items]
  (match items
    [l r & rest] (make-pairs [;acc [l r]] rest)
    [l] (make-pairs [;acc [l [:div]]] [])
    [] acc))

(defn item-list [items]
  (map (fn [x] [:div {:class "grid"} ;x]) (make-pairs [] (map item-card items))))

(defn cart-table []
  [:article [:table [:thead [:tr [:th "Item"] [:th "Quantity"] [:th "Actions"]]] [:tbody]]])
