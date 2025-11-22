(use judge)

(import ../src/attributes)

(test (map |(apply attributes/computed ;$&)
           [["$count % 2 === 0" :blinker]
            ["{foo: () => $bar + $baz}"]])
      @[["data-computed:blinker"
         "$count % 2 === 0"]
        ["data-computed"
         "{foo: () => $bar + $baz}"]])

(test (attributes/effect "hello") ["data-effect" "hello"])

(test (attributes/ref "foo" [:case :camel]) ["data-ref__case.camel" "foo"])

(test (attributes/bind "foo") ["data-bind" "foo"])

(test (attributes/text "$foo") ["data-text" "$foo"])

(test (attributes/on :click "$foo = evt.detail" :window "debounce.1s")
      ["data-on:click__window__debounce.1s"
       "$foo = evt.detail"])

(deftest class
  (test (attributes/class {:text-primary "$primary" :font-bold "$bold"})
        ["data-class"
         "{\"font-bold\":\"$bold\",\"text-primary\":\"$primary\"}"])
  (test (attributes/class "$foo" :hidden) ["data-class:hidden" "$foo"])
  (test (attributes/class "$foo" :hidden [:case :camel]) ["data-class:hidden__case.camel" "$foo"])
  (test (attributes/class {:text-primary true} nil [:case :camel])
        ["data-class__case.camel"
         "{\"text-primary\":true}"]))

(deftest attr
  (test (attributes/attr {:disabled "$input == ''"})
        ["data-attr"
         "{\"disabled\":\"$input == ''\"}"])

  (test (attributes/attr "$foo" :title) ["data-attr:title" "$foo"]))

(test (attributes/signals {:input 1 :form {:input 2}} nil :ifmissing)
      ["data-signals__ifmissing"
       "{\"form\":{\"input\":2},\"input\":1}"])
(test (attributes/signals "1" "foo.bar") ["data-signals:foo.bar" "1"])
(test (attributes/signals {:foo :null}) ["data-signals" "{\"foo\":null}"])

(test (attributes/indicator :fetching) ["data-indicator" :fetching])
(test (attributes/indicator :fetching [:case :camel]) ["data-indicator__case.camel" :fetching])

(test (attributes/show "$showMe") ["data-show" "$showMe"])

(test (attributes/on-intersect "console.log('Hi')" :once)
      ["data-on-intersect__once"
       "console.log('Hi')"])

(test (attributes/ignore) ["data-ignore" ""])
(test (attributes/ignore :self) ["data-ignore__self" ""])

(test (attributes/ignore-morph) ["data-ignore-morph" ""])

(test (attributes/init "$count = 1") ["data-init" "$count = 1"])
(test (attributes/init "$count = 1" [:delay "500ms"]) ["data-init__delay.500ms" "$count = 1"])

(test (attributes/json-signals) ["data-json-signals" ""])
(test (attributes/json-signals "{include: /user/}")
      ["data-json-signals"
       "{include: /user/}"])
(test (attributes/json-signals "{include: /user/}" :terse)
      ["data-json-signals__terse"
       "{include: /user/}"])

(test (attributes/on-interval "$count++" [:duration "500ms"])
      ["data-on-interval__duration.500ms"
       "$count++"])

(test (attributes/on-signal-patch "console.log('A signal changed!')" [:debounce "1s"])
      ["data-on-signal-patch__debounce.1s"
       "console.log('A signal changed!')"])

(test (attributes/on-signal-patch-filter "{include: /user/, exclude: /password/}")
      ["data-on-signal-patch-filter"
       "{include: /user/, exclude: /password/}"])

(test (attributes/preserve-attr :open :class) ["data-preserve-attr" "open class"])

(test (attributes/style {:display :none :color :red})
      ["data-style"
       "{\"color\":\"red\",\"display\":\"none\"}"])
(test (attributes/style "$usingRed ? 'red' : 'blue'" :background-color)
      ["data-style:background-color"
       "$usingRed ? 'red' : 'blue'"])

# PRO

(test (attributes/animate) ["data-animate"])

(test (attributes/custom-validity "$foo === $bar ? '' : 'Values must be the same.'")
      ["data-custom-validity"
       "$foo === $bar ? '' : 'Values must be the same.'"])

(test (attributes/custom-validity "$foo === $bar ? '' : 'Fields must be the same.'")
      ["data-custom-validity"
       "$foo === $bar ? '' : 'Fields must be the same.'"])

(test (attributes/on-raf "$count++" [:throttle "1s" :trailing])
      ["data-on-raf__throttle.1s.trailing"
       "$count++"])


(test (attributes/on-resize "$count++" [:throttle "1s" :trailing])
      ["data-on-resize__throttle.1s.trailing"
       "$count++"])

(test (map |(apply attributes/persist ;$&)
           [[]
            ["{include: /foo/, exclude: /bar/}"]
            [nil :mykey]
            [nil :mykey :session]])
      @[["data-persist:datastar" ""]
        ["data-persist:datastar"
         "{include: /foo/, exclude: /bar/}"]
        ["data-persist:mykey" ""]
        ["data-persist:mykey__session" ""]])

(test (map |(apply attributes/query-string ;$&)
           [[]
            ["{include: /foo/, exclude: /bar/}"]
            [nil :filter :history]])
      @[["data-query-string" ""]
        ["data-query-string"
         "{include: /foo/, exclude: /bar/}"]
        ["data-query-string__filter__history"
         ""]])

(test (attributes/replace-url "/page${page}") ["data-replace-url" "`/page${page}`"])

(test (attributes/scroll-into-view :instant :focus)
      ["data-scroll-into-view__instant__focus"
       ""])

(test (attributes/view-transition :foo) ["data-view-transition" "foo"])
