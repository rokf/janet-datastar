(use judge)

(import ../src/events)

(test (events/patch-elements `<div id="foo">Hello world!</div>`) "event: datastar-patch-elements\ndata: elements <div id=\"foo\">Hello world!</div>\n\n")

(test (events/patch-elements ["<div>"
                              "Hello world!"
                              "</div>"])
      "event: datastar-patch-elements\ndata: elements <div>\ndata: elements Hello world!\ndata: elements </div>\n\n")

(test (events/patch-elements `<div id="foo">Hello world!</div>`
                             :mode :outer
                             :selector "#foo"
                             :useViewTransitions :true)
      "event: datastar-patch-elements\ndata: selector #foo\ndata: useViewTransitions true\ndata: mode outer\ndata: elements <div id=\"foo\">Hello world!</div>\n\n")

(test (events/patch-signals {:foo 1 :bar 2}) "event: datastar-patch-signals\ndata: onlyIfMissing false\ndata: signals {\"foo\":1,\"bar\":2}\n\n")

(test (events/patch-signals {:foo :null :bar :null}) "event: datastar-patch-signals\ndata: onlyIfMissing false\ndata: signals {\"foo\":null,\"bar\":null}\n\n")

(test (events/patch-signals {:foo 1 :bar 2} true) "event: datastar-patch-signals\ndata: onlyIfMissing true\ndata: signals {\"foo\":1,\"bar\":2}\n\n")
