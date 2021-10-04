defmodule Common do
  def parse_main_document(body) do
    {:ok, document} = Floki.parse_document(body)
    document
  end

  @doc """
  Find all urls from parsed document of page https://github.com/h4cc/awesome-elixir/blob/master/README.md
  """
  def find_all_urls(array) do
    Enum.map(array, fn {_tag, href, _name} -> href end)
    |> List.flatten()
  end

  @doc """
  Filter by correct urls of repositories
  """
  def filter_by_correct_url(array) do
    Enum.filter(array, fn {_href, url} ->
      String.starts_with?(url, "https://github.com/")
    end)
  end

  @doc """
  Get author and repo name from url of repository
  """
  def get_author_and_repo_from_url(urls) do
    Enum.map(urls, fn {_href, url} ->
      author = Enum.at(String.split(url, "/"), 3)
      repo = Enum.at(String.split(url, "/"), 4)

      %{author: author, repo: repo}
    end)
  end

  def create_api_urls(data) do
    Enum.map(data, fn %{author: author, repo: repo} ->
      "https://api.github.com/repos/#{author}/#{repo}"
    end)
  end

  def filter_by_min_stars(array, stars) do
    Enum.filter(array, fn %{stargazers_count: stars_amount} ->
      stars_amount > stars
    end)
  end
end
