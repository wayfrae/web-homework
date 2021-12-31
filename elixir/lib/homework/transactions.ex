defmodule Homework.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Homework.Repo

  alias Homework.Transactions.Transaction
  alias Homework.Companies.Company
  alias Homework.Users.User
  alias Homework.Pagination.Paginator
  alias Homework.Schema.Helpers
  alias HomeworkWeb.Schemas.Pagination.Page

  @doc """
  Returns the list of transactions using the given args.
  """
  def list_transactions(args) do
    Helpers.process_args(Transaction, args)
  end

  @doc """
  Returns the list of transactions for a specific company

  ## Examples

      iex> list_transactions(%Company{}, [])
      [%Transaction{}, ...]

  """
  def list_transactions(company_id, args) do
    get_transactions_by_company_query(company_id)
    |> Helpers.process_args(args)
  end

  @doc """
  Sums all transactions for a specific company

  ## Examples

      iex> sum_transactions(%Company{})
      1234567

  """
  def sum_transactions(%Company{} = company) do
    (from q in get_transactions_by_company_query(company.id),
    select: sum(q.amount))
    |> Repo.one
  end

  defp get_transactions_by_company_query(company_id) do
    from t in Transaction,
      join: u in User, on: t.user_id == u.id,
      where: u.company_id == type(^company_id, :binary_id)
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end
end
