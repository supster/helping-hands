class CaseWorkflowValue < ActiveRecord::Base
  attr_accessible :workflow_id, :state_id, :action_id, :save_attr
  belongs_to :user_case
  belongs_to :workflow
  belongs_to :state
  belongs_to :action
end
