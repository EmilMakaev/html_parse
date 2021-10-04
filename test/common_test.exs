defmodule CommonTest do
  use ExUnit.Case
  doctest Common

  # TEST find all urls
  @find_all_urls_input [
    {"a", [{"href", "#awesome-elixir"}], ["Awesome Elixir"]},
    {"a", [{"href", "#actors"}], ["Actors"]},
    {"a", [{"href", "https://github.com/spawnproc/bpe"}], ["BPE: Business Process Engine"]},
    {"a", [{"href", "https://github.com/dalmatinerdb/dflow"}], ["Dflow"]}
  ]
  @find_all_urls_output [
    {"href", "#awesome-elixir"},
    {"href", "#actors"},
    {"href", "https://github.com/spawnproc/bpe"},
    {"href", "https://github.com/dalmatinerdb/dflow"}
  ]

  test "find all urls" do
    assert Common.find_all_urls(@find_all_urls_input) == @find_all_urls_output
  end

  # TEST filter by correct url
  @filter_by_correct_url_output [
    {"href", "https://github.com/spawnproc/bpe"},
    {"href", "https://github.com/dalmatinerdb/dflow"}
  ]

  test "filter by correct url" do
    assert Common.filter_by_correct_url(@find_all_urls_output) ==
             @filter_by_correct_url_output
  end

  # TEST get author and repo name from url
  @get_author_and_repo_from_url_output [
    %{author: "spawnproc", repo: "bpe"},
    %{author: "dalmatinerdb", repo: "dflow"}
  ]

  test "get author and repo name from url" do
    assert Common.get_author_and_repo_from_url(@filter_by_correct_url_output) ==
             @get_author_and_repo_from_url_output
  end

  # TEST create api urls
  @create_api_urls_output [
    "https://api.github.com/repos/spawnproc/bpe",
    "https://api.github.com/repos/dalmatinerdb/dflow"
  ]

  test "create api urls" do
    assert Common.create_api_urls(@get_author_and_repo_from_url_output) ==
             @create_api_urls_output
  end
end
