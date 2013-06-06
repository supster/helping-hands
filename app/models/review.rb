class Review < ActiveRecord::Base
  attr_accessible :name, :review_score, :review_text, :program_id, :location_id
  belongs_to :program
  belongs_to :location

  validates :program_id, presence: true
  validates :location_id, presence: true
  validates :review_text, presence: true, length: { maximum: 2000 }
  validates :review_score, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
end