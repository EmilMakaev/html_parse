defmodule FakeData do
  def fake_urls do
    [
      "https://api.github.com/repos/spawnproc/bpe",
      "https://api.github.com/repos/dalmatinerdb/dflow",
      "https://api.github.com/repos/sasa1977/exactor"
    ]
  end

  def fake_author_repo_data() do
    [
      %{author: "spawnproc", repo: "bpe"},
      %{author: "dalmatinerdb", repo: "dflow"}
    ]
  end

  def finished_fake_data() do
    [
      %{id: 16_749_477, last_commit_time: 97, name: "bpe", stargazers_count: 193},
      %{id: 27_992_949, last_commit_time: 1466, name: "dflow", stargazers_count: 11},
      %{id: 7_670_698, last_commit_time: 605, name: "exactor", stargazers_count: 663},
      %{id: 24_095_229, last_commit_time: 344, name: "exos", stargazers_count: 72},
      %{id: 77_396_145, last_commit_time: 455, name: "flowex", stargazers_count: 400}
    ]
  end
end
