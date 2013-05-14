class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :description
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :url
      t.string :email
      t.references :agency

      t.timestamps
    end
    add_index :locations, :agency_id
  end
end
