ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(ApiGithub.Repo, :manual)

Mox.defmock(ApiGithub.Github.ClientMock, for: ApiGithub.Github.Behavior)
