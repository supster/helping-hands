class WorkflowsController < ApplicationController
  def index
  	if !params[:area].nil?
  	  @workflows = Workflow.where("area_id = " + params[:area])
  	else
  	  @workflows = Workflow.order("start_state_id")
  	end
  end

  def show
    @workflow = Workflow.find(params[:id])
  	@states = @workflow.states.order("id")
  	#@actions = Action.where("state_id = " + @state.id.to_s)
  end

  def new
    @workflow = Workflow.new
    1.times do
      state = @workflow.states.build
      2.times { state.actions.build }
    end
  end

  def create
    @workflow = Workflow.new(params[:workflow])
    if @workflow.save
      redirect_to @workflow, :notice => "Successfully created workflow."
    else
      render :action => 'new'
    end
  end

  def edit
    @workflow = Workflow.find(params[:id])
  end

  def update
    @workflow = Workflow.find(params[:id])
    if @workflow.update_attributes(params[:workflow])
      redirect_to @workflow, :notice  => "Successfully updated workflow."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @workflow = Workflow.find(params[:id])
    @workflow.destroy
    redirect_to workflows_url, :notice => "Successfully destroyed workflow."
  end  
end
