defmodule HomeworkWeb.Schema do
  @moduledoc """
  Defines the graphql schema for this project.
  """
  use Absinthe.Schema

  alias HomeworkWeb.Resolvers.CompaniesResolver
  alias HomeworkWeb.Resolvers.MerchantsResolver
  alias HomeworkWeb.Resolvers.TransactionsResolver
  alias HomeworkWeb.Resolvers.UsersResolver
  import_types(HomeworkWeb.Schemas.Types)

  query do
    @desc "Get all Transactions"
    field(:transactions, list_of(:transaction)) do
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

    @desc "Get all Users"
    field(:users, list_of(:user)) do
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

    @desc "Get all Merchants"
    field(:merchants, list_of(:merchant)) do
      @desc "The id to get"
      arg(:id, :id)
      @desc "The list of ids to get"
      arg(:ids, list_of(:id))
      @desc "The number of results to skip"
      arg(:skip, :integer)
      @desc "The number of results to get"
      arg(:limit, :integer)
      resolve(&MerchantsResolver.merchants/3)
    end

    @desc "Get all Companies"
    field(:companies, list_of(:company)) do
      @desc "The id to get"
      arg(:id, :id)
      @desc "The list of ids to get"
      arg(:ids, list_of(:id))
      @desc "The number of results to skip"
      arg(:skip, :integer)
      @desc "The number of results to get"
      arg(:limit, :integer)
      resolve(&CompaniesResolver.companies/3)
    end
  end

  mutation do
    import_fields(:transaction_mutations)
    import_fields(:user_mutations)
    import_fields(:merchant_mutations)
    import_fields(:company_mutations)
  end
end
