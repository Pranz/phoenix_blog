defmodule Mix.Tasks.PersonalSite do
  use Mix.Task

  @shortdoc "Publishes the file in the argument. If no arg is given, publishes most recently modified."
  def run(args) do
    filename = case args do
      [filename | _] ->
        (filename <> ".md")
          |> Path.expand |> Path.absname
      _ ->
        "./posts"
          |> File.ls!
          |> Enum.sort_by(
            fn filename -> (File.lstat! filename).mtime end, &>=/2)
          |> Enum.at(0)
    end
    contents = File.read! filename
    {:ok, _resp} = HTTPoison.post "localhost:4000/posts", contents
    IO.puts "published " <> filename
  end
end
