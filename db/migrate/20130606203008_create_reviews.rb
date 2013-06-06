class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :review_score
      t.text :review_text
      t.string :name
      t.references :program
      t.references :location

      t.timestamps
    end
    add_index :reviews, :program_id
    add_index :reviews, :location_id
  end
end
