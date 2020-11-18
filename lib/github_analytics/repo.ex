defmodule GithubAnalytics.Repo do
  use Ecto.Repo,
    otp_app: :github_analytics,
    adapter: Ecto.Adapters.Postgres
end
