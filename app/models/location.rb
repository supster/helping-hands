class Location < ActiveRecord::Base
  attr_accessible :address, :city, :description, :name, :phone, :state, 
  				  :url, :email, :zip, :agency_id, :latitude, :longitude
  belongs_to :agency

  acts_as_gmappable :lat => 'latitude', :lng => 'longitude',# :process_geocoding => :geocode?,
                  :address => "gmaps4rails_address"#, :normalized_address => "address"

  def gmaps4rails_address
  	"#{address}, #{city}, #{state}"
  end

  def gmaps4rails_infowindow
  	"#{name}</br>" << "#{address},#{city}, #{state}, #{zip}"
  end

  #geocoded_by :gmaps4rails_address
end
