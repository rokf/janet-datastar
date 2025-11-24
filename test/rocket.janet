(use judge)

(import ../src/rocket :as rocket)

(test (rocket/rocket "example") ["data-rocket:example" ""])

(test (rocket/static) ["data-static" ""])

(test (rocket/props :step "int|min:1|max:10|=1")
      ["data-props:step"
       "int|min:1|max:10|=1"])

(test (rocket/import-esm :qr "https://cdn.jsdelivr.net/npm/qr-creator@1.0.0/+esm")
      ["data-import-esm:qr"
       "https://cdn.jsdelivr.net/npm/qr-creator@1.0.0/+esm"])

(test (rocket/import-iife :chart "https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.js")
      ["data-import-iife:chart"
       "https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.js"])

(test (rocket/shadow-open) ["data-shadow-open" ""])

(test (rocket/shadow-closed) ["data-shadow-open" ""])

(test (rocket/if "$$errs?.start") ["data-if" "$$errs?.start"])

(test (rocket/else-if "$$items.count == 1") ["data-else-if" "$$items.count == 1"])

(test (rocket/else) ["data-else" ""])

(test (rocket/for "item, index in $$items") ["data-for" "item, index in $$items"])
