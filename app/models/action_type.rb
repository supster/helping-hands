class ActionType < ActiveRecord::Base
  attr_accessible :name
  has_many :states
end
