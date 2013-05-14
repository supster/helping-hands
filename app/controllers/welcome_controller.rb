class WelcomeController < ApplicationController

  def home
  	@area = Area.all	
  end

end
