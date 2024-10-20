(use judge)

(import ../src/actions)

(test (actions/get "/users/1") "$$get('/users/1')")

(test (actions/post "/users") "$$post('/users')")

(test (actions/put "/users/1") "$$put('/users/1')")

(test (actions/patch "/users/1") "$$patch('/users/1')")

(test (actions/delete "/users/1") "$$delete('/users/1')")

(test (actions/is-fetching "#foo") "$$isFetching('#foo')")

(test (actions/set-all "contact_" "$selections.all") "$$setAll('contact_', $selections.all)")

(test (actions/toggle-all "contact_") "$$toggleAll('contact_')")

(test (actions/clipboard "Hello, World!") "$$clipboard('Hello, World!')")

(test (actions/fit 1 2 3 4 5) "$$fit(1, 2, 3, 4, 5)")

(test (actions/fit-int 1 2 3 4 5) "$$fitInt(1, 2, 3, 4, 5)")

(test (actions/clamp-fit 1 2 3 4 5) "$$clampFit(1, 2, 3, 4, 5)")

(test (actions/clamp-fit-int 1 2 3 4 5) "$$clampFitInt(1, 2, 3, 4, 5)")
