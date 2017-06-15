defmodule Mse.Web.Admin.GathererController do
  use Mse.Web, :controller
  import ExAdmin.Utils

  def update(conn, %{"gatherer_import" => %{"xml" => xml}}) do
    %Plug.Upload{path: path} = xml

    Exq.enqueue(Exq, "default", Workers.Admin.GathererImport, [path])

    redirect(conn, to: admin_path())
  end
end
