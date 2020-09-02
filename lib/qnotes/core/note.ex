defmodule Qnotes.Core.Note do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [type: :utc_datetime_usec]

  schema "notes" do
    field(:body, :string)
    field(:image_path, :string)
    field(:title, :string)
    field(:uid, :string)

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :body, :uid, :image_path])
    |> validate_required([:title, :body, :image_path])
    |> put_uid()
  end

  # it will put a uid only for insertion of new records
  @spec put_uid(Ecto.Changeset.t()) :: Ecto.Changeset.t()
  defp put_uid(%{data: %{id: nil}} = changeset) do
    put_change(changeset, :uid, Nanoid.generate())
  end

  defp put_uid(changeset), do: changeset
end
