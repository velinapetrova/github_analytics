defmodule GithubAnalytics.Github do
  use HTTPoison.Base

  @endpoint Application.get_env(:github_analytics, :github)[:graphql_api_url]
  @token Application.get_env(:github_analytics, :github)[:bearer_token]

  def process_request_headers(headers) do
    headers
    |> Keyword.put_new(:Authorization, @token)
    |> Keyword.put_new(:"Content-Type", "application/json")
  end

  def process_request_body(body) when body == "", do: body

  def process_request_body(body) do
    case Jason.encode(body) do
      {:ok, encoded} -> encoded
      {:error, error} -> %{error: error}
    end
  end

  def process_response_body(body) when body == "", do: body

  def process_response_body(body) do
    case Jason.decode(body) do
      {:ok, decoded} -> decoded
      {:error, error} -> %{error: error}
    end
  end

  def fetch_data(query) do
    @endpoint
    |> post(%{query: query})
    |> format_standard_response()
  end

  def format_standard_response(response) do
    case response do
      {:ok, %HTTPoison.Response{body: body, status_code: 200}} -> body
      {:error, error} -> {:error, error}
    end
  end
end
