class State < ActiveRecord::Base
  attr_accessible :name, :description, :workflow_id, 
  				  :form_name, :form_param 
  belongs_to :workflow
  has_many :actions

  validates :name, presence: true, length: { maximum: 255 }  
end
