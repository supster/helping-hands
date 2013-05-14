class Workflow < ActiveRecord::Base
  attr_accessible :name, :description, :start_state_id, :area_id
  belongs_to :area
  has_many :states

  validates :name, presence: true, length: { maximum: 255 }

end
