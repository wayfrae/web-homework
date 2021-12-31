defmodule Homework.CompaniesTest do
  use Homework.DataCase

  alias Homework.Companies

  describe "companies" do
    alias Homework.Companies.Company

    @valid_attrs %{
      name: "some company",
      credit_line: 5_000_000
    }

    @update_attrs %{
      name: "some updated company",
      credit_line: 10_000_000
    }

    @invalid_attrs %{
      name: nil,
      credit_line: nil
    }

    def company_fixture(attrs \\ %{}) do
      {:ok, company} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Companies.create_company()

      company
    end

    test "list_companies/1 returns all companies" do
      company1 = company_fixture()
      company2 = company_fixture(@update_attrs)
      assert Companies.list_companies([]) == [company1, company2]
    end

    test "get_company!/1 returns the company with the given id" do
      company = company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "get_company!/1 raises error when not found" do
      assert_raise Ecto.NoResultsError, fn ->
        Companies.get_company!("0e31998f-503f-4218-a801-c8bb7ff9498b")
      end
    end

    test "create_company/1 with valid data creates a company" do
      assert {:ok, %Company{} = company} = Companies.create_company(@valid_attrs)
      assert company.name == "some company"
      assert company.credit_line == 5_000_000
    end

    test "create_company/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_company(@invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = company_fixture(@valid_attrs)
      assert {:ok, %Company{} = company} = Companies.update_company(company, @update_attrs)
      assert company.name == "some updated company"
      assert company.credit_line == 10_000_000
    end

    test "update_company/2 with invalid data returns error changeset" do
      company = company_fixture(@valid_attrs)
      assert {:error, %Ecto.Changeset{}} = Companies.update_company(company, @invalid_attrs)
      assert company == Companies.get_company!(company.id)
    end
  end
end
