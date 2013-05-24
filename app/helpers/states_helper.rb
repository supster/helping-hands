module StatesHelper

  class Rule
  	def is_match(workflow_name)
  	end
  	def calculate_eligibility(user)
  	end
  end

  class RuleEngine
  	def initialize
  		
  	end
  	def calculate (workflow_name, user_case)
  		
  	end
  end

  class	Eligibility
  	attr_accessor :eligible, :service_id, :message
  end

  class AdultMedicaidRule < Rule
  	def is_match(workflow_name)
  		workflow_name.downcase == "finding health insurance"
  	end

  	def calculate_eligibility(user_case)
  	  #need household_size, age and income level to calc
  	  @eligible = Eligibility(eligible: true, service_id: 1, message: "testing")
  	  @eligible
  	end
  end

  class	HighSchoolRule < Rule
  end

end
