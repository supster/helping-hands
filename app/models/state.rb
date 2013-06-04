class State < ActiveRecord::Base
  attr_accessible :name, :description, :workflow_id, 
  				  :form_name, :form_param, :action_type_id
  attr_accessible :actions_attributes
  belongs_to 	:workflow
  has_many 		:actions, dependent: :destroy
  belongs_to 	:action_type
  accepts_nested_attributes_for :actions, allow_destroy: true

  validates :name, presence: true, length: { maximum: 255 }  

  #def next (action)
  #	action.next_state_id
  #end

end
