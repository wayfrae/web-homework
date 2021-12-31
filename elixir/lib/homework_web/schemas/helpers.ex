defmodule Homework.Schema.Helpers do
  import Ecto.Query
  alias Homework.Repo
  alias Homework.Pagination.Paginator
  alias HomeworkWeb.Pagination.Page

  def process_args(model, args)do
    case args do
      %{skip: skip, limit: limit} ->
        Paginator.paginate(model, skip, limit)

      %{skip: skip} ->
        Paginator.paginate(model, skip)

      %{limit: limit} ->
        Paginator.paginate(model, 0, limit)

      %{id: id, skip: skip, limit: limit} ->
        by_id(model, [id], skip, limit)

      %{id: id, skip: skip} ->
        by_id(model, [id], skip)

      %{id: id, limit: limit} ->
        by_id(model, [id], limit)

      %{id: id} ->
        by_id(model, [id])

      %{ids: ids, skip: skip, limit: limit} ->
        by_id(model, ids, skip, limit)

      %{ids: ids, skip: skip} ->
        by_id(model, ids, skip)

      %{ids: ids, limit: limit} ->
        by_id(model, ids, limit)

      %{ids: ids} ->
        by_id(model, ids)

      %{} ->
        Paginator.paginate(model)
      [] ->
        Paginator.paginate(model)
    end
  end

  def by_id(model, ids, skip \\ 0, limit \\ 0) do

    ids = ids |> Enum.uniq

    model
    |> where([m], m.id in ^ids)
    |> Paginator.paginate(skip, limit)
  end
end
