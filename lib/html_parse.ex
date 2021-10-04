defmodule HtmlParse do
  @doc """
  Prepare api urls for fetching data
  """
  def init do
    Api.make_http_request()
    |> Common.parse_main_document()
    |> Floki.find("article li a")
    |> Common.find_all_urls()
    |> Common.filter_by_correct_url()
    |> Common.get_author_and_repo_from_url()
    |> Common.create_api_urls()
  end

  def run_async_task(urls) do
    Task.async_stream(urls, fn url -> DataProcessing.run_task(url) end)
    |> Enum.into([], fn {:ok, res} -> res end)
  end

  def call_api_async() do
    init()
    |> run_async_task()
  end

  def call_api_async_by_filter(stars) do
    init()
    |> run_async_task()
    |> Common.filter_by_min_stars(stars)
  end
end
