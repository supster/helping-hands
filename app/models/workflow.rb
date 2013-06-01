class Workflow < ActiveRecord::Base
  attr_accessible :name, :description, :start_state_id, :area_id, :service_id
  attr_accessible :states_attributes
  belongs_to :area
  has_many :states, dependent: :destroy
  belongs_to :service
  accepts_nested_attributes_for :states

  validates :name, presence: true, length: { maximum: 255 }

end
