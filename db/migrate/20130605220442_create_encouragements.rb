class CreateEncouragements < ActiveRecord::Migration
  def change
    create_table :encouragements do |t|
      t.string :name
      t.text :description
      t.references :workflow

      t.timestamps
    end
  end
end
