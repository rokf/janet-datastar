(import redka)

(defn seed [db]
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

(defn items [db &opt search]
  (default search "")
  (map |(let [item (table ;(redka/hgetall db $))]
          {:id $
           :image (item "image")
           :name (item "name")
           :description (item "description")
           :price (item "price")
           :stock (item "stock")}) (redka/keys db (string/format "items:%s*" search))))
