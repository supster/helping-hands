class Location < ActiveRecord::Base
  acts_as_gmappable process_geocoding: false
  attr_accessible :address, :city, :description, :name, :phone, :state, 
  				  :url, :email, :zip, :agency_id, :latitude, :longitude
  belongs_to :agency

  def gmaps4rails_address
  	"#{name}, #{state}"
  end

  def gmaps4rails_infowindow
  	"#{name}</br>" << "#{address},#{city}, #{state}, #{zip}"
  end
end
