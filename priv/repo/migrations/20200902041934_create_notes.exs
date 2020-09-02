defmodule Qnotes.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def up do
    create table(:notes) do
      add :title, :string, null: false
      add :body, :text, null: false
      add :uid, :string, null: false
      add :image_path, :string, null: false

      timestamps(type: :utc_datetime_usec)
    end
  end

  def down do
    drop table(:notes)
  end
end
