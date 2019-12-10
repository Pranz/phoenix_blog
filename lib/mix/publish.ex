defmodule Mix.Tasks.PersonalSite.Publish do
  use Mix.Task

  @shortdoc "Publishes the file in the argument. If no arg is given, publishes most recently modified."
  def run(args) do
    HTTPoison.start()
    filename = case args do
      [filename | _] ->
        filename
          |> Path.expand() |> Path.absname
      _ ->
        "./posts"
          |> File.ls!
          |> Enum.map(fn x -> x |> Path.expand("./posts") |> Path.absname end)
          |> Enum.sort_by(
            fn filename -> (File.lstat! filename).mtime end, &>=/2)
          |> Enum.at(0)
    end
    url = case args do
      [_ | ["prod" | _]] -> "https://jesperfridefors.se/posts"
      _ -> "http://localhost:4000/posts"
    end

    publish_file(url, filename)

    if Enum.member?(args, "--watch") do
      :fs.start_link(:post_watcher, filename |> Path.dirname)
      :fs.subscribe(:post_watcher)

      IO.puts "Start watching for updates"

      recv_loop(filename, url)
    end
  end

  defp recv_loop(filename, url) do
    receive do
      {_pid, {:fs, :file_event}, {changedFile, type}} ->
        if("#{filename}" == "#{changedFile}" && type == [:modified, :closed]) do
          publish_file(url, filename)
        end
    end
    recv_loop(filename, url)
  end

  defp publish_file(url, filename) do
    IO.inspect url
    IO.inspect filename
    contents = File.read! filename
    resp = HTTPoison.post! url, contents
    IO.puts resp.body
    200 = resp.status_code
    IO.puts "published " <> filename
  end
end
