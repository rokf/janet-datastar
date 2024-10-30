# janet-datastar

This is a Janet utility library for building web applications using the [Datastar](https://data-star.dev) hypermedia framework. It primarily contains helper functions for the various attributes, actions, and event types that Datastar is offering. It is meant to be used together with Janet's [spork](https://github.com/janet-lang/spork) library (`htmlgen` and `http` modules).

> [!IMPORTANT]
>
> This library is not yet stable. Even though it probably contains functions for all of the functionality that Datastar is offering they have not all been tested yet, at least not well enough. Expect changes. I'll start adding semantic version tags once things stabilise.

## API

The library is split into multiple modules:

- `datastar` contains middleware and other stuff that doesn't exactly fit into any of the submodules.
- `datastar/attributes` contains helper functions for Datastar's HTML attributes, such as `data-store`.
- `datastar/actions` contains helper functions for Datastar's actions, such as `$$clipboard`.
- `datastar/events` contains helper functions for all the SSE response types (events) Datastar is supporting, such as `datastar-fragment` or `datastar-redirect`.
- `datastar/server` contains a slightly customized HTTP server implementation from `spork/http`, because the original does not (yet) support everything that'd be needed for it to work well with the Datastar framework.

See the [API](./API.md) reference for details.

## Installation

The library can be installed with **jpm** using `jpm install https://github.com/rokf/janet-datastar` or by adding the following line into your project's dependency tuple:

```janet
{ :url "https://github.com/rokf/janet-datastar" :tag "main" }
```

## Example

An example can be found in the `example` folder. It requires the following dependencies:

- https://github.com/ianthehenry/pat
- https://github.com/janet-lang/spork
- https://github.com/rokf/janet-redka

The folder contains a Docker Compose specification which can be used to spin up a properly configured Redka instance (see `compose.yaml`).

## Tests

See the contents of the `test` folder. The tests require [judge](https://github.com/ianthehenry/judge). Make sure that it's installed on your machine before you run them with `judge test`.

## License

MIT - see the `LICENSE` file at the root of the repository for details.
