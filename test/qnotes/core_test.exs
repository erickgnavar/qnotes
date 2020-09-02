defmodule Qnotes.CoreTest do
  use Qnotes.DataCase

  alias Qnotes.Core

  describe "notes" do
    alias Qnotes.Core.Note

    @valid_attrs %{
      body: "some body",
      image_path: "some image_path",
      title: "some title",
      uid: "some uid"
    }
    @update_attrs %{
      body: "some updated body",
      image_path: "some updated image_path",
      title: "some updated title",
      uid: "some updated uid"
    }
    @invalid_attrs %{body: nil, image_path: nil, title: nil, uid: nil}

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Core.create_note()

      note
    end

    test "list_notes/0 returns all notes" do
      note = note_fixture()
      assert Core.list_notes() == [note]
    end

    test "get_note!/1 returns the note with given id" do
      note = note_fixture()
      assert Core.get_note!(note.id) == note
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} = Core.create_note(@valid_attrs)
      assert note.body == "some body"
      assert note.image_path == "some image_path"
      assert note.title == "some title"
      refute is_nil(note.uid)
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Core.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, %Note{} = note} = Core.update_note(note, @update_attrs)
      assert note.body == "some updated body"
      assert note.image_path == "some updated image_path"
      assert note.title == "some updated title"
      assert note.uid == "some updated uid"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Core.update_note(note, @invalid_attrs)
      assert note == Core.get_note!(note.id)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Core.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Core.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Core.change_note(note)
    end
  end
end
