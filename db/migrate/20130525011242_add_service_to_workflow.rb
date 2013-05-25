class AddServiceToWorkflow < ActiveRecord::Migration
  def change
    add_column :workflows, :service_id, :integer
  end
end
