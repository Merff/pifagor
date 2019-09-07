## Pifagor

**The Trading Candles generator on Elixir**

### Get running (local)
1. `git clone git@github.com:Merff/pifagor.git pifagor`
2. `cd pifagor`
3. `mix deps.get`
4. Set db credentials in `dev.exs` and `test.exs`
5. `mix ecto.create`
6. `mix ecto.migrate`
7. Now you can run: `mix test`

For run producing data just run:

`iex -S mix` and wait some seconds =)

Я использовал Postgres в качестве хранилища данных, т.к. это было наиболее просто.
Так же можно было использовать что-то вроде DTS или Mnesia.

Набросал простой scheduler на GenServer, но можно было использовать готовые решения вроде библиотеки Quantum.
