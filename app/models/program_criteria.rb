class ProgramCriteria < ActiveRecord::Base
  attr_accessible :name, :value
  belongs_to :program
end
