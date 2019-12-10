defmodule PersonalSiteWeb.FeedbackController do
    use PersonalSiteWeb, :controller
    import Plug.Conn
    alias PersonalSite.Repo
    alias PersonalSite.Feedback

    def create(conn, params) do
      res = params
        |> Feedback.changeset(%Feedback{})
        |> Repo.insert!

      case res do
        {:ok, _} -> json conn, %{ status: "created" }
        _ -> send_resp conn, 400, "requires body and topic"
      end
      json conn, %{ status: "created" }
    end

    def index(conn, _params) do
      json conn, Repo.all Feedback
    end

end
