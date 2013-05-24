class AddSaveToAction < ActiveRecord::Migration
  def change
    add_column :actions, :save, :string
  end
end
