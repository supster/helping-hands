class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.string :name
      t.string :description
      t.references :area
      t.integer :start_state_id

      t.timestamps
    end
    add_index :workflows, :area_id
  end
end
