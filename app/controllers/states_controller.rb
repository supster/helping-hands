class StatesController < ApplicationController
  def show
  	#@workflow = Workflow.find(params[:workflow_id])
  	@workflow_id = params[:workflow_id]
  	@state = State.find_by_id(params[:id])
  	@actions = Action.where("state_id = ?", params[:id]).order("id")
  	@addresses = []
  	@json=[]

  	if !@state.form_name.nil? and @state.form_name == "show_programs"
  		@programs = Service.find_by_name(@state.form_param).programs.includes(:agency => :locations)
  		if @programs
  			@programs.each do |program|
	  			program.agency.locations.each do |address|
	  				@addresses << address
	  			end
	  		end
  		end
  	end
  	@json = @addresses.to_gmaps4rails
  end


end
