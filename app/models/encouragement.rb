class Encouragement < ActiveRecord::Base
  attr_accessible :description, :name, :workflow_id
  belongs_to :workflow
end
