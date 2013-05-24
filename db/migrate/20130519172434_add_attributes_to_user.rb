class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :age, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :household_size, :integer
    add_column :users, :monthly_income, :float
    add_column :users, :citizen, :boolean
    add_column :users, :immigrant, :boolean
  end
end
