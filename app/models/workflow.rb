class Workflow < ActiveRecord::Base
  attr_accessible :name, :description, :start_state_id, :area_id, :service_id, :img
  attr_accessible :states_attributes
  belongs_to :area
  has_many :states, dependent: :destroy
  has_many :encouragements, dependent: :destroy
  belongs_to :service
  accepts_nested_attributes_for :states, allow_destroy: true

  validates :name, presence: true, length: { maximum: 255 }

end
