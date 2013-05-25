class CreateProgramCriteria < ActiveRecord::Migration
  def change
    create_table :program_criteria do |t|
      t.references :program
      t.string :name
      t.string :value

      t.timestamps
    end
    add_index :program_criteria, :program_id
  end
end
