# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Homework.Repo.insert!(%Homework.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule SeedHelper do
  def create_transactions(amount, isDebit, merchant, user) do
    description = if(isDebit, do: "Debit", else: "Credit") <> " from #{merchant.name}"
    Homework.Transactions.create_transaction(%{amount: amount, debit: isDebit, credit: !isDebit, description: description, merchant_id: merchant.id, user_id: user.id, company_id: user.company_id})
  end
end

{_, bigCompany} = Homework.Companies.create_company(%{name: "Big Company", credit_line: 500_000_000})
{_, mediumCompany} = Homework.Companies.create_company(%{name: "Medium Company", credit_line: 60_000_000})
{_, smallCompany} = Homework.Companies.create_company(%{name: "Small Company", credit_line: 10_000_000})

{_, officeSupplies} = Homework.Merchants.create_merchant(%{description: "Office supplies", name: "Office Supplies R Us"})
{_, burgerDome} = Homework.Merchants.create_merchant(%{description: "Restaurant", name: "Burger Dome"})
{_, pizzaPalace} = Homework.Merchants.create_merchant(%{description: "Restaurant", name: "Pizza Palace"})
{_, luxuryInn} = Homework.Merchants.create_merchant(%{description: "Hotel", name: "Luxury Inn"})
{_, nile} = Homework.Merchants.create_merchant(%{description: "Online Retail", name: "Nile, Inc."})
{_, foodAndStuff} = Homework.Merchants.create_merchant(%{description: "Grocery/Retail", name: "Food and Stuff"})

{_, jimBob} = Homework.Users.create_user(%{first_name: "Jim", last_name: "Bob", dob: "01/24/1991", company_id: bigCompany.id})
{_, joeBob} = Homework.Users.create_user(%{first_name: "Joe", last_name: "Bob", dob: "04/26/1987", company_id: bigCompany.id})
{_, johnDoe} = Homework.Users.create_user(%{first_name: "John", last_name: "Doe", dob: "06/06/2002", company_id: bigCompany.id})
{_, janeRoberts} = Homework.Users.create_user(%{first_name: "Jane", last_name: "Roberts", dob: "01/01/2001", company_id: bigCompany.id})
{_, jillJackson} = Homework.Users.create_user(%{first_name: "Jill", last_name: "Jackson", dob: "02/24/1992", company_id: bigCompany.id})
{_, maryJeanPaul} = Homework.Users.create_user(%{first_name: "Mary", last_name: "Jean-Paul", dob: "04/24/1981", company_id: mediumCompany.id})
{_, sallyJohnson} = Homework.Users.create_user(%{first_name: "Sally", last_name: "Johnson", dob: "01/14/2001", company_id: mediumCompany.id})
{_, davidQuackenbush} = Homework.Users.create_user(%{first_name: "David", last_name: "Quackenbush", dob: "02/24/1991", company_id: mediumCompany.id})
{_, chrisPace} = Homework.Users.create_user(%{first_name: "Chris", last_name: "Pace", dob: "01/24/1990", company_id: smallCompany.id})
{_, samThayer} = Homework.Users.create_user(%{first_name: "Sam", last_name: "Thayer", dob: "11/23/1997", company_id: smallCompany.id})

merchants = [officeSupplies, burgerDome, pizzaPalace, luxuryInn, nile, foodAndStuff]
users = [jimBob, joeBob, johnDoe, janeRoberts, jillJackson, maryJeanPaul, sallyJohnson, davidQuackenbush, chrisPace, samThayer]

# Create random transactions for each user
Enum.each(users, fn user -> for _n <- 1..Enum.random(4..20), do: SeedHelper.create_transactions(:rand.uniform(1_000_000), :rand.uniform(2) == 1, Enum.random(merchants), user) end)
