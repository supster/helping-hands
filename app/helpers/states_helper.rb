module StatesHelper

  class Rule
  	def is_match(workflow_service)
  	end
  	def calculate_eligibility(workflow, user_case)
  	end
  end

  class RuleEngine
  	@aRule
  	def initialize
  	  @aRule = Array.new
  	  @aRule << AdultMedicaidRule.new
  	  #@aRule << ChildHealthPlusRule.new
  	  @aRule.push OtherServiceRule.new
  	end

  	def calculate (workflow, user_case)
  	  @aRule.each do |oRule|
  	  	if oRule.is_match(workflow.service.name)
  	  	  program_id = oRule.calculate_eligibility(workflow, user_case)
  	  	  return program_id
  	  	end
  	  end
  	end
  end

  class AdultMedicaidRule < Rule 	
  	def is_match(workflow_service)
  	  workflow_service.downcase == "health insurance"
  	end

  	def calculate_eligibility(workflow, user_case)
  	  #need household_size, age and income level to calculate
  	  #@eligible = Eligibility.new(eligible: true, service_id: 1, message: "testing")
  	  #@eligible
  	  prog_id = Array.new
  	  case_wf = CaseWorkflowValue.where("user_case_id = ? and workflow_id = ?", user_case.id, workflow.id)
  	  programs = Service.find_by_id(workflow.service_id).programs.order("id")
  	  household_size = 1
  	  monthly_income = 0
      age = ""
  	  case_wf.each do |wf|
  	  	case wf.state.name.downcase
        when ""
  	  	  when "check household size"
  	  	    household_size = wf.save_attr.split(":")[1]
  	  	  when "check monthly income"
  	  	  	monthly_income = wf.save_attr.split(":")[1]
          when "check age"
            age = wf.save_attr.split(":")[1]
  	  	end
  	  end

      if age == "<19"
        #child program
        prog_id.push programs.third
      else
        if monthly_income.to_f < 1000
          prog_id.push programs.first
        else
          prog_id.push programs.second
        end
      end
  	  return prog_id
  	end
  end

  class ChildHealthPlusRule < Rule
  	def is_match(workflow_service)
  	  workflow_name.downcase == "child health insurance"
  	end

  	def calculate_eligibility(workflow, user_case)
  	  #need household_size, age and income level to calc
  	end
  end

  class	OtherServiceRule < Rule
  	def is_match(workflow_service)
  	  true
  	end

  	def calculate_eligibility(workflow, user_case)
  	  prog_id = Array.new
  	  case_wf = CaseWorkflowValue.where("user_case_id = ? and workflow_id = ?", user_case.id, workflow.id)
  	  programs = Service.find_by_id(workflow.service_id).programs
  	  
  	  programs.each do |pro|
  	    satisfied = true #start with true because if no criteria is defined, we should return everything
  	    pro.program_criterias.each do |cri|
	  	  case_wf.each do |wf|
	  	  	if cri.name.downcase == wf.state.name.downcase 
	  	  	  if cri.value != wf.save_attr
	  	  	  	satisfied = false # if criteria does not satisfied, return false
	  	  	  end
	  	  	end
	  	  end
	  	end
  	  	prog_id.push pro.id if satisfied == true
  	  end  	  
      return prog_id
    end
  end
end