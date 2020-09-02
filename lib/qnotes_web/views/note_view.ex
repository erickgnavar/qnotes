defmodule QnotesWeb.NoteView do
  use QnotesWeb, :view
  alias Qnotes.Core.Note

  def generate_b64_qr(conn, %Note{uid: uid}) do
    conn
    |> QnotesWeb.Router.Helpers.url()
    |> Kernel.<>(Routes.note_path(conn, :public, uid))
    |> QRCode.create!()
    |> QRCode.Svg.to_base64()
  end

  def image_url(%Note{image_path: path}) do
    Qnotes.Photo.url(path, signed: true)
  end
end
