module StatesHelper

  class Rule
  	def calculate_eligibility(user)
  	end
  end

  class AdultMedicaidRule < Rule
  	def calculate_eligibility(user)
  	  #need household_size, age and income level to calc
  	end
  end
end
