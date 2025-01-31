(use judge)

(import ../src/attributes)

(test (attributes/computed :blinker "$count % 2 === 0")
      ["data-computed-blinker"
       "$count % 2 === 0"])

(test (attributes/ref "foo") [:data-ref "foo"])

(test (attributes/bind "foo") ["data-bind" "foo"])

(test (attributes/text "$foo") ["data-text" "$foo"])

(test (attributes/custom-validity "$foo === $bar ? '' : 'Fields must be the same.'")
      ["data-custom-validity"
       "$foo === $bar ? '' : 'Fields must be the same.'"])

(test (attributes/on :click "$$fn('foo', 123)" :window "debounce.1s")
      ["data-on-click__window__debounce.1s"
       "$$fn('foo', 123)"])

(test (attributes/persist) ["data-persist-datastar" ""])
(test (attributes/persist nil "hello") ["data-persist-datastar" "hello"])
(test (attributes/persist "hello" "world") ["data-persist-hello" "world"])
(test (attributes/persist "hello" [:first "second"]) ["data-persist-hello" "first second"])
(test (attributes/persist "hello" [:first "second"] :session)
      ["data-persist-hello__session"
       "first second"])

(test (attributes/replace-url "/hello/${world}") ["data-replace-url" "`/hello/${world}`"])

(test (attributes/class {:text-primary "$primary" :font-bold "$bold"})
      ["data-class"
       "{\"font-bold\":\"$bold\",\"text-primary\":\"$primary\"}"])

(test (attributes/attr {:disabled "$input == ''"})
      ["data-attr"
       "{\"disabled\":\"$input == ''\"}"])

(test (attributes/signals {:input 1 :form {:input 2}} :ifmissing)
      ["data-signals__ifmissing"
       "{\"form\":{\"input\":2},\"input\":1}"])

(test (attributes/indicator :fetching) ["data-indicator" "$fetching"])

(test (attributes/show "$showMe") ["data-show" "$showMe"])

(test (attributes/intersects "console.log('Hi')" :once)
      ["data-intersects__once"
       "console.log('Hi')"])

(test (attributes/scroll-into-view :instant :focus)
      ["data-scroll-into-view__instant__focus"
       ""])

(test (attributes/view-transition :foo) ["data-view-transition" :foo])

(test (attributes/ignore) ["data-star-ignore" ""])
