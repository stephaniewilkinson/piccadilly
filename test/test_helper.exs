ExUnit.start()
ExUnit.configure(exclude: :pending, trace: true)
Ecto.Adapters.SQL.Sandbox.mode(Piccadilly.Repo, :manual)
