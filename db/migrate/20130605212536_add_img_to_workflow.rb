class AddImgToWorkflow < ActiveRecord::Migration
  def change
    add_column :workflows, :img, :string
  end
end
