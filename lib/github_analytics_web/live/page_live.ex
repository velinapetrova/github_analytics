defmodule GithubAnalyticsWeb.PageLive do
  use GithubAnalyticsWeb, :live_view

  alias GithubAnalytics.Query

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, display_repository_data: false)}
  end

  @impl true
  def handle_event("submit", %{"repository" => %{"name" => name, "owner" => owner}}, socket) do
    repository = get_repository_data(name, owner)

    socket =
      socket
      |> assign(name_with_owner: repository["nameWithOwner"])
      |> assign(description: repository["description"])
      |> assign(url: repository["homepageUrl"])
      |> assign(created_at: repository["createdAt"])
      |> assign(stargazer_count: repository["stargazerCount"])
      |> assign(fork_count: repository["forkCount"])
      |> assign(display_repository_data: true)

    {:noreply, socket}
  end

  defp get_repository_data(name, owner) do
    case Query.repository(name, owner) do
      {:ok, repository} ->
        repository
      {:error, _} ->
        %{}
    end
  end
end
