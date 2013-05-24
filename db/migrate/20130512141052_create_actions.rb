class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.references :state
      t.string :name
      t.string :description
      t.integer :next_state_id
      t.integer :sub_workflow_id
      t.integer :order_no

      t.timestamps
    end
    add_index :actions, :state_id
  end
end
