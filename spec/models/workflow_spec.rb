require 'spec_helper'

describe Workflow do
  before do
  	@workflow = Workflow.new(name: "Workflow 1", description: "Test Workflow",
  							 start_state_id: 1)
  end

  subject { @workflow }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:start_state_id) }

  it { should be_valid }

  describe "when name is not present" do
  	before { @workflow.name = "" }
  	it { should_not be_valid }
  end
end
