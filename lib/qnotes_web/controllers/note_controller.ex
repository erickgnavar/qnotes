defmodule QnotesWeb.NoteController do
  use QnotesWeb, :controller

  alias Qnotes.Core
  alias Qnotes.Core.Note

  def index(conn, _params) do
    notes = Core.list_notes()
    render(conn, "index.html", notes: notes)
  end

  def new(conn, _params) do
    changeset = Core.change_note(%Note{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"note" => note_params}) do
    case Core.create_note(note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note created successfully.")
        |> redirect(to: Routes.note_path(conn, :show, note))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    note = Core.get_note!(id)
    render(conn, "show.html", note: note)
  end

  def public(conn, %{"uid" => uid}) do
    note = Core.get_note_by!(uid: uid)
    render(conn, "public.html", note: note)
  end

  def edit(conn, %{"id" => id}) do
    note = Core.get_note!(id)
    changeset = Core.change_note(note)
    render(conn, "edit.html", note: note, changeset: changeset)
  end

  def update(conn, %{"id" => id, "note" => note_params}) do
    note = Core.get_note!(id)

    case Core.update_note(note, note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note updated successfully.")
        |> redirect(to: Routes.note_path(conn, :show, note))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", note: note, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    note = Core.get_note!(id)
    {:ok, _note} = Core.delete_note(note)

    conn
    |> put_flash(:info, "Note deleted successfully.")
    |> redirect(to: Routes.note_path(conn, :index))
  end
end
