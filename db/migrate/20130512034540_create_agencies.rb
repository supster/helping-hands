class CreateAgencies < ActiveRecord::Migration
  def change
    create_table :agencies do |t|
      t.string :name
      t.string :description
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
