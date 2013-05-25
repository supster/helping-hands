class CreateUserCases < ActiveRecord::Migration
  def change
    create_table :user_cases do |t|
      t.integer :id
      t.string :case_token

      t.timestamps
    end

    add_index  :user_cases, :case_token
  end
end
