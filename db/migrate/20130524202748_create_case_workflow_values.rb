class CreateCaseWorkflowValues < ActiveRecord::Migration
  def change
    create_table :case_workflow_values do |t|
      t.references :user_case
      t.references :workflow
      t.references :state
      t.references :action
      t.string :save_attr

      t.timestamps
    end
    add_index :case_workflow_values, :user_case_id
    add_index :case_workflow_values, :workflow_id
    add_index :case_workflow_values, :state_id
    add_index :case_workflow_values, :action_id
  end
end
