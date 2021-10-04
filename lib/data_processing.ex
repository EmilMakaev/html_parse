defmodule DataProcessing do
  @doc """
  Define how many days have passed since the last commit
  """
  def define_last_commit_time(date) do
    {:ok, datetime, 0} = DateTime.from_iso8601(date)

    div(DateTime.diff(DateTime.utc_now(), datetime), 86400)
  end

  @doc """
  Return the required data or message error
  """
  def parse_data(data) do
    repo_data = Poison.Parser.parse!(data)

    if repo_data["id"] do
      %{
        id: repo_data["id"],
        name: repo_data["name"],
        stargazers_count: repo_data["stargazers_count"],
        last_commit_time: define_last_commit_time(repo_data["pushed_at"])
      }
    else
      repo_data["message"]
    end
  end

  @doc """
  Make a http request and then parse them
  """
  def run_task(url) do
    %{body: body, status_code: status_code} = Api.make_http_request(url)

    case status_code do
      200 ->
        parse_data(body)

      301 ->
        redirect_data = Poison.Parser.parse!(body)
        redirect_url = redirect_data["url"]
        %HTTPoison.Response{body: redirect_body} = HTTPoison.get!(redirect_url)
        parse_data(redirect_body)

      _ ->
        {:error, "Error #{body}"}
    end
  end
end
