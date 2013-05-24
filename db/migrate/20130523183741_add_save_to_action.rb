class AddSaveToAction < ActiveRecord::Migration
  def change
    add_column :actions, :save_attr, :string
  end
end
