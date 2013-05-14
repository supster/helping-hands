class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.references :workflow
      t.string  :name
      t.text 	:description
      t.string	:form_name
      t.string	:form_param
      
      t.timestamps
    end
    add_index :states, :workflow_id
  end
end
