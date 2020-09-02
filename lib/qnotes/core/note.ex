defmodule Qnotes.Core.Note do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime_usec]

  schema "notes" do
    field(:body, :string)
    field(:image, :string, virtual: true)
    field(:image_path, :string)
    field(:title, :string)
    field(:uid, :string)

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :body, :uid, :image_path])
    |> validate_required([:title, :body])
    |> put_uid()
    |> process_image_upload(Map.get(attrs, "image"))
  end

  # it will put a uid only for insertion of new records
  @spec put_uid(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp put_uid(%{data: %{id: nil}} = changeset) do
    put_change(changeset, :uid, Nanoid.generate())
  end

  defp put_uid(changeset), do: changeset

  defp process_image_upload(%{valid?: true} = changeset, %Plug.Upload{} = upload) do
    {:ok, image_path} =
      upload
      |> generate_image_path()
      |> Qnotes.Photo.store()

    put_change(changeset, :image_path, image_path)
  end

  defp process_image_upload(changeset, _upload), do: changeset

  defp generate_image_path(%Plug.Upload{filename: filename} = upload) do
    [_name, extension] = String.split(filename, ".")
    filename = Nanoid.generate() <> "." <> extension
    Map.put(upload, :filename, filename)
  end
end
