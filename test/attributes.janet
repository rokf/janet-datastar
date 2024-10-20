(use judge)

(import ../src/attributes)

(test (attributes/store {:foo 1234} :local) ["data-store.local" "{\"foo\":1234}"])

(test (attributes/ref "foo") [:data-ref "foo"])

(test (attributes/bind :disabled "$shouldBeDisabled")
      ["data-bind-disabled"
       "$shouldBeDisabled"])

(test (attributes/model "foo") ["data-model" "foo"])

(test (attributes/text "$foo") ["data-text" "$foo"])

(test (attributes/on :click "$$fn('foo', 123)") ["data-on-click" "$$fn('foo', 123)"])

(test (attributes/fetch-indicator "#spinner") [:data-fetch-indicator "#spinner"])

(test (attributes/show "$showMe" "duration_100ms") ["data-show.duration_100ms" "$showMe"])

(test (attributes/intersect "console.log('Hi')" :once)
      ["data-intersect.once"
       "console.log('Hi')"])

(test (attributes/teleport "#foo" :prepend) ["data-teleport.prepend" "#foo"])

(test (attributes/scroll-into-view :instant :focus)
      ["data-scroll-into-view.instant.focus"
       :true])

(test (attributes/view-transition :foo) ["data-view-transition" :foo])
