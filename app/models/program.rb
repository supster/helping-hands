class Program < ActiveRecord::Base
  attr_accessible :description, :name, :url, :agency_id
  belongs_to :agency
  has_and_belongs_to_many :services
  has_many :program_criterias
end
