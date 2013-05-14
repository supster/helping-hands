class Agency < ActiveRecord::Base
  attr_accessible :description, :email, :name, :phone
  has_many :programs
  has_many :locations
end
