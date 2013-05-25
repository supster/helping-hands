class StatesController < ApplicationController
  before_filter :store_case

  def show
    @workflow_id = params[:workflow_id]
    @workflow = Workflow.find(@workflow_id)
    @state_id = params[:id]
    
    if params[:next_state_id].nil?
    	@state = State.find_by_id(@state_id)
    	@actions = Action.where("state_id = ?", @state_id).order("order_no")
    else
      # We should save data to the database here
      cwf = current_case.case_workflow_values.where("workflow_id = ? and state_id = ?", @workflow_id, @state_id)
      if cwf.count <= 0
        current_case.case_workflow_values.create(workflow_id: @workflow_id, state_id: @state_id,
                                                    action_id: params[:action_id], save_attr: params[:save])
      else  
        cwf.first.update_attributes(action_id: params[:action_id], save_attr: params[:save])
      end

      if params[:next_state_id] != ""
        # end of workflow state so we calculate rules and display programs that satisfied the rules
        if params[:next_state_id] == "0"
          #calculate Rule          
          rule = RuleEngine.new
          @program_ids = rule.calculate(@workflow, current_case)
          #logger.debug "program ids: " + @prog_id.to_s
          @addresses = []
          @json=[]

          #@programs = Service.find_by_name(@state.form_param).programs.includes(:agency => :locations)
          @programs = Program.find(@program_ids)
          @programs.each do |program|
            program.agency.locations.each do |address|
              @addresses << address
            end
          end
          @json = @addresses.to_gmaps4rails

          render "states/programs"
        else
          redirect_to workflow_state_path @workflow_id, params[:next_state_id]
        end
      else
        render :end_wf # if next state is blank shows not eligible page
      end
    end

  end

  def final
    @program = Program.find_by_id(params[:prog])
    @location = Location.find_by_id(params[:loc])
    @json=@location.to_gmaps4rails
  end

  def end_wf
  end


end
