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

      # filter by ID with pagination
      %{id: id, skip: skip, limit: limit} ->
        by_id(model, [id], skip, limit)

      %{id: id, skip: skip} ->
        by_id(model, [id], skip)

      %{id: id, limit: limit} ->
        by_id(model, [id], limit)

      %{id: id} ->
        by_id(model, [id])

      # filter by list of IDs with pagination
      %{ids: ids, skip: skip, limit: limit} ->
        by_id(model, ids, skip, limit)

      %{ids: ids, skip: skip} ->
        by_id(model, ids, skip)

      %{ids: ids, limit: limit} ->
        by_id(model, ids, limit)

      %{ids: ids} ->
        by_id(model, ids)

      #filter by min/max amount
      %{min: min, max: max} ->
        by_min_max(model, min, max)

      %{min: min, max: max, skip: skip} ->
        by_min_max(model, min, max, skip)

      %{min: min, max: max, limit: limit} ->
        by_min_max(model, min, max, limit)

      %{min: min, max: max, skip: skip, limit: limit} ->
        by_min_max(model, min, max, skip, limit)

      #filter by min amount
      %{min: min} ->
        by_min(model, min)

      %{min: min, skip: skip} ->
        by_min(model, min, skip)

      %{min: min, limit: limit} ->
        by_min(model, min, limit)

      %{min: min, skip: skip, limit: limit} ->
        by_min(model, min, skip, limit)

      #filter by max amount
      %{max: max} ->
        by_max(model, max)

      %{max: max, skip: skip} ->
        by_max(model, max, skip)

      %{max: max, skip: skip, limit: limit} ->
        by_max(model, max, limit)

      %{max: max, skip: skip, limit: limit} ->
        by_max(model, max, skip, limit)

      # default
      %{} ->
        Paginator.paginate(model)
      [] ->
        Paginator.paginate(model)
    end
  end

  defp by_id(model, ids, skip \\ 0, limit \\ 0) do
    ids = ids |> Enum.uniq

    model
    |> where([m], m.id in ^ids)
    |> Paginator.paginate(skip, limit)
  end

  defp by_min(model, min, skip \\ 0, limit \\ 0) do
    model
    |> where([m], m.amount >= ^min)
    |> Paginator.paginate(skip, limit)
  end

  defp by_max(model, max, skip \\ 0, limit \\ 0) do
    model
    |> where([m], m.amount <= ^max)
    |> Paginator.paginate(skip, limit)
  end

  defp by_min_max(model, min, max, skip \\ 0, limit \\ 0) do
    model
    |> where([m], m.amount >= ^min and m.amount <= ^max)
    |> Paginator.paginate(skip, limit)
  end
end
