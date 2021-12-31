defmodule HomeworkWeb.Schemas.UsersSchema do
  @moduledoc """
  Defines the graphql schema for user.
  """
  use Absinthe.Schema.Notation

  alias HomeworkWeb.Resolvers.UsersResolver

  object :user do
    field(:id, non_null(:id))
    field(:dob, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:company_id, :id)
    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)

    field(:company, :company) do
      resolve(&UsersResolver.company/3)
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
      resolve(&TransactionsResolver.transactions/3)
    end
  end

  object :user_mutations do
    @desc "Create a new user"
    field :create_user, :user do
      arg(:dob, non_null(:string))
      arg(:first_name, non_null(:string))
      arg(:last_name, non_null(:string))

      resolve(&UsersResolver.create_user/3)
    end

    @desc "Update a new user"
    field :update_user, :user do
      arg(:id, non_null(:id))
      arg(:dob, non_null(:string))
      arg(:first_name, non_null(:string))
      arg(:last_name, non_null(:string))

      resolve(&UsersResolver.update_user/3)
    end

    @desc "delete an existing user"
    field :delete_user, :user do
      arg(:id, non_null(:id))

      resolve(&UsersResolver.delete_user/3)
    end
  end
end
