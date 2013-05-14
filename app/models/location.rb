class Location < ActiveRecord::Base
  attr_accessible :address, :city, :description, :name, :phone, :state, 
  				  :url, :email, :zip, :agency_id
  belongs_to :agency
end
