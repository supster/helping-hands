class WelcomeController < ApplicationController

  def home
  	@area = Area.all	
  end

  def show
  	
  end
end
