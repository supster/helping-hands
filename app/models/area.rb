class Area < ActiveRecord::Base
  attr_accessible :name, :description
  has_many :workflows

  validates :name, presence: true, length: { maximum: 255 }
end
