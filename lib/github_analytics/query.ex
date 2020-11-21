defmodule GithubAnalytics.Query do
  @moduledoc false

  alias GithubAnalytics.Github

  def username do
    query = "query { viewer { login } }"

    case Github.fetch_data(query) do
      %{"data" => %{"viewer" => %{"login" => username}}} ->
        username
      _ ->
        "default_user_name"
    end
  end

  def repository(name, owner) do
    query = """
      query {
        repository(name: "#{name}", owner: "#{owner}") {
        nameWithOwner
        description
        homepageUrl
        createdAt
        stargazerCount
        forkCount
      }
    }
    """

    case Github.fetch_data(query) do
      %{"data" => %{"repository" => repository}} ->
        {:ok, repository}
      _ ->
        {:error, nil}
    end
  end
end
