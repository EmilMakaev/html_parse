defmodule Api do
  def make_http_request() do
    %HTTPoison.Response{body: body} =
      HTTPoison.get!("https://github.com/h4cc/awesome-elixir/blob/master/README.md")

    body
  end

  def api_headers do
    [
      Authorization: "Bearer YOUR_TOKEN",
      Accept: "application / vnd.github.v3 + json"
    ]
  end

  def make_http_request(url) do
    %HTTPoison.Response{body: body, status_code: status_code} = HTTPoison.get!(url, api_headers())

    %{body: body, status_code: status_code}
  end
end
