class Action < ActiveRecord::Base
  attr_accessible :description, :name, :state_id, :next_state_id, 
  				  :sub_workflow_id
  belongs_to :state
end
