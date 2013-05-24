class AddActionTypeToState < ActiveRecord::Migration
  def change
    add_column :states, :action_type_id, :integer
  end
end
