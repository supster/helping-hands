class StatesController < ApplicationController
  def show
  	#@workflow = Workflow.find(params[:workflow_id])
    @workflow_id = params[:workflow_id]
    
    if params[:next_state_id].nil?
    	@state = State.find_by_id(params[:id])
    	@actions = Action.where("state_id = ?", params[:id]).order("order_no")
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
    else
        # We should save hidden variable values here

      if params[:next_state_id] != "" 
        redirect_to workflow_state_path @workflow_id, params[:next_state_id]
      else
        render "end_wf"
      end
    end

  end

  def final
    @program = Program.find_by_id(params[:prog])
    @location = Location.find_by_id(params[:loc])
  end

  def end_wf
  end


end
