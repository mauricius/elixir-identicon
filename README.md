# Elixir Identicon

_This project is mostly for learning purposes._

[Identicon](https://en.wikipedia.org/wiki/Identicon) generator built with Elixir. Loosely inspired by the code from this [Udemy course](https://www.udemy.com/course/the-complete-elixir-and-phoenix-bootcamp-and-tutorial).

## Install

- Make sure you have [Elixir](https://elixir-lang.org/) installed. On a Mac you can use `brew install elixir`
- Run `mix deps.get` and `mix escript.build`

## Usage

Use the compiled binary:

```
$ ./identicon test
```

will generate the identicon for the `test` input string in the current folder, as a 250x250 PNG image.

Alternatively you can output the identicon directly to console, using the `--console` switch

```
$ ./identicon test --console
```

You can run the program within the REPL interactive console:

```
$ iex -S mix run
iex(1)> Identicon.console("test")
:ok
iex(2)> Identicon.output("test")
:ok
```

## Development

- compile dependencies `mix deps.compile`
- run the tests with `mix test`
- format code using `mix format`

## Notes

I used [Dialyxir](https://github.com/jeremyjh/dialyxir) to check for [types](https://hexdocs.pm/elixir/typespecs.html) errors. Dialyxir is a wrapper around the Erlang tool [Dialyzer](http://erlang.org/doc/man/dialyzer.html), which is a static analysis tool for Erlang and other languages that compile to BEAM bytecode.

## License

[MIT](LICENSE)