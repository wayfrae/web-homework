defmodule HomeworkWeb.Schemas.CompaniesSchema do
  @moduledoc """
  Defines the graphql schema for companies.
  """
  use Absinthe.Schema.Notation

  alias HomeworkWeb.Resolvers.TransactionsResolver
  alias HomeworkWeb.Resolvers.CompaniesResolver
  alias HomeworkWeb.Resolvers.UsersResolver
  alias Homework.Transactions.Transaction

  @desc ""
  object :company do
    field(:id, non_null(:id))
    field(:name, :string)
    field(:credit_line, :float)
    field :available_credit, :float do
      resolve fn company, _, _ ->
        {_, sum} = TransactionsResolver.sum_transactions(company)
        {:ok, company.credit_line - sum}
      end
    end
    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)
    field :users, list_of(:user) do
      @desc "The id to get"
      arg(:id, :id)
      @desc "The list of ids to get"
      arg(:ids, list_of(:id))
      @desc "The number of results to skip"
      arg(:skip, :integer)
      @desc "The number of results to get"
      arg(:limit, :integer)
      resolve(&UsersResolver.users/3)
    end
    field :transactions, list_of(:transaction) do
      @desc "The id to get"
      arg(:id, :id)
      @desc "The list of ids to get"
      arg(:ids, list_of(:id))
      @desc "The number of results to skip"
      arg(:skip, :integer)
      @desc "The number of results to get"
      arg(:limit, :integer)
      @desc "The minimum amount for returned transactions (in cents)"
      arg(:min, :integer)
      @desc "The maximum amount for returned transactions (in cents)"
      arg(:max, :integer)
      resolve(&TransactionsResolver.transactions/3)
    end
  end

  object :company_mutations do
    @desc "Create a new company"
    field :create_company, :company do
      arg(:name, non_null(:string))
      arg(:credit_line, non_null(:integer))

      resolve(&CompaniesResolver.create_company/3)
    end

    @desc "Update a new company"
    field :update_company, :company do
      arg(:id, non_null(:id))
      arg(:name, non_null(:string))
      arg(:credit_line, non_null(:integer))

      resolve(&CompaniesResolver.update_company/3)
    end

    @desc "delete an existing company"
    field :delete_company, :company do
      arg(:id, non_null(:id))

      resolve(&CompaniesResolver.delete_company/3)
    end
  end
end
