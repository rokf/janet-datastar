(use judge)

(import ../src/actions)

(test (actions/peek :bar) "@peek(() => $bar)")

(test (actions/get "/users/1") "@get('/users/1', {})")

(test (actions/post "/users") "@post('/users', {})")

(test (actions/put "/users/1") "@put('/users/1', {})")

(test (actions/patch "/users/1") "@patch('/users/1', {})")

(test (actions/delete "/users/1") "@delete('/users/1', {})")

(test (actions/set-all "contact_" "$selections.all") "@setAll('contact_', $selections.all)")

(test (actions/toggle-all "contact_") "@toggleAll('contact_')")

# PRO

(test (actions/fit 1 2 3 4 5) "@fit(1, 2, 3, 4, 5, false, false)")

(test (actions/clipboard "Hello, world!") "@clipboard('Hello, world!', false)")
(test (actions/clipboard "SGVsbG8sIHdvcmxkIQ==" :true) "@clipboard('SGVsbG8sIHdvcmxkIQ==', true)")
