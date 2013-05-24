class Action < ActiveRecord::Base
  attr_accessible :description, :name, :state_id, :next_state_id, 
  				  :sub_workflow_id, :order_no, :save_attr
  belongs_to :state

  validates :name, presence: true, length: { maximum: 50 }

end
