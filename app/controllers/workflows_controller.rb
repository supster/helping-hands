class WorkflowsController < ApplicationController
  def index
  	if !params[:area].nil?
  	  @workflows = Workflow.where("area_id = " + params[:area])
  	else
  	  @workflows = Workflow.all
  	end
  end

  def show
    @workflow = Workflow.find(params[:id])
  	@states = @workflow.states.order("id")
  	#@actions = Action.where("state_id = " + @state.id.to_s)
  end
end
