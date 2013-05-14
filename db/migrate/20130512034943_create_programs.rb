class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.text :description
      t.string :url
      t.references :agency

      t.timestamps
    end
    add_index :programs, :agency_id
  end
end
