defmodule Mix.Tasks.PersonalSite.Publish do
  use Mix.Task

  @shortdoc "Publishes the file in the argument. If no arg is given, publishes most recently modified."
  def run(args) do
    HTTPoison.start()
    filename = case args do
      [filename | _] ->
        (filename <> ".md")
          |> Path.expand |> Path.absname
      _ ->
        "./posts"
          |> File.ls!
          |> Enum.map(fn x -> x |> Path.expand("./posts") |> Path.absname end)
          |> Enum.sort_by(
            fn filename -> (File.lstat! filename).mtime end, &>=/2)
          |> Enum.at(0)
    end
    contents = File.read! filename
    resp = HTTPoison.post! "http://localhost:4000/posts", contents
    IO.puts resp.body
    200 = resp.status_code
    IO.puts "published " <> filename
  end
end
