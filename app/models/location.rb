class Location < ActiveRecord::Base
  acts_as_gmappable
  attr_accessible :address, :city, :description, :name, :phone, :state, 
  				  :url, :email, :zip, :agency_id
  belongs_to :agency

  def gmaps4rails_address
  	"#{name}, #{state}"
  end

  def gmaps4rails_infowindow
  	"#{name}</br>" << "#{address},#{city}, #{state}, #{zip}"
  end
end
