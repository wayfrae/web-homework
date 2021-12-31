defmodule Homework.Pagination.Paginator do
  @moduledoc """
  Used to add pagination to queries
  """

  import Ecto.Query
  alias Homework.Repo

  def paginate(query, number_to_skip \\ 0, results_per_page \\ 0) do
    run_query(query, number_to_skip, results_per_page)
  end

  defp run_query(query, number_to_skip, _results_per_page = 0) do
    query
    |> offset(^number_to_skip)
    |> Repo.all
  end

  defp run_query(query, number_to_skip, results_per_page) do
    query
    |> limit(^results_per_page)
    |> offset(^number_to_skip)
    |> Repo.all
  end

  defp sum_total_results(query) do
    Repo.aggregate(query, :count, :id)
  end
end
