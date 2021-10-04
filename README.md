## 1. Add your Github token here lib/api.ex. Function api_headers

# 2. Start

iex -S mix

## 3. Run by function call_api_async

HtmlParse.call_api_async()

## 4. When we send query parameter, we call function call_api_async_by_filter

HtmlParse.call_api_async_by_filter(100)

## Additional information

You can play around with fake data. Just use this functions in html_parse file:

def call_api_async() do
FakeData.fake_urls()
|> run_async_task()
end

def call_api_async_by_filter(stars) do
FakeData.finished_fake_data()
|> Common.filter_by_min_stars(stars)
end
