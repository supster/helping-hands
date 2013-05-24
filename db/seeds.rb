# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
	
["YesNo", "InputForm", "FAQ", "ProgramForm"].each do |a|
  ActionType.find_or_create_by_name(a)
end


["Education", "Work", "Health", "Food", "Housing", "Money", "Child Care"].each do |a|
  Area.find_or_create_by_name(a)
end
Workflow.delete_all
State.delete_all
Action.delete_all

area_id = Area.find_by_name("Education").id
#Education - Finish Highschool
workflow = Workflow.create(name: "I need help finishing High School.", 
						 description: "I need help staying in school or getting a GED.", area_id: area_id)

state = State.create(name: "Check Age", description: "Are you 21 or older?", workflow_id: workflow.id, action_type_id: 1)
workflow.start_state_id = state.id
workflow.save

action1 = Action.new(name: "Yes", description: "21 or older", save_attr: "age: >=21", state_id: state.id, order_no: 0)
action2 = Action.new(name: "No", description: "Younger than 21", save_attr: "age: <21", state_id: state.id, order_no: 1)

# Older than 21
state = State.create(name: "Adult Learning Programs", 
			description: "GED preparation classes can help you reach your goal!<br> 
						 Please contact one of these program centers near you:",
			workflow_id: workflow.id,
			form_name: "show_programs", form_param: "Adult GED", action_type_id: 4)
action1.next_state_id = state.id
action1.save

# Younger than 21
state = State.create(name: "High School Alternatives", 
				description: "You are in luck! There are multiple programs that can help.
						 You might be eligible for Transfer Schools, Young Adult Borough Centers (YABCs), or GED Plus.",
				workflow_id: workflow.id,
				form_name: "show_programs", form_param: "High School Alternatives", action_type_id: 4)
action2.next_state_id = state.id
action2.save

#Education - Improve my English
workflow = Workflow.create(name: "I want to improve my English.", 
						 description: "I want to take English language classes.", area_id: area_id)


#Education - Learn career and technical skills
workflow = Workflow.create(name: "I need career training.", 
						 description: "I want to learn career and technical skills.", area_id: area_id)


#Work - Learn career and technical skills
area_id = Area.find_by_name("Work").id
workflow = Workflow.create(name: "I need help finding a job or internship.", 
						 description: "I want to learn career and technical skills.", area_id: area_id)

## Workflow Number 2 - Medicaid
area_id = Area.find_by_name("Health").id
workflow = Workflow.create(name: "I need health insurance.", 
						 description: "I need help getting health insurance.", area_id: area_id)

#check age
state = State.create(name: "Check Age", description: "How old are you?", workflow_id: workflow.id, action_type_id: 1)
workflow.start_state_id = state.id
workflow.save

action1 = Action.create(name: "Younger than 19", description: "Younger than 19", state_id: state.id, order_no: 0) #END
action2 = Action.new(name: "19 to 65", description: "19 to 65", state_id: state.id, order_no: 1)
action3 = Action.new(name: "Older than 65", description: "Older than 65", state_id: state.id, order_no: 2)

#check residency
state = State.create(name: "Check Residency", description: "Do you live in New York State?", workflow_id: workflow.id, action_type_id: 1)
action2.next_state_id = state.id
action2.save
action3.next_state_id = state.id
action3.save

action1 = Action.new(name: "Yes", description: "Live in New York", state_id: state.id, order_no: 0)
action2 = Action.new(name: "No", description: "Don't live in New York", state_id: state.id, order_no: 1) # END
action2.save

#Do you have a proof of residency? (e.g. XXXXXX)
state = State.create(name: "Check Proof of Residency", description: "Do you have a proof of residency? (e.g. Driver's License, etc)", 
				     workflow_id: workflow.id, action_type_id: 1)
action1.next_state_id = state.id
action1.save

action1 = Action.new(name: "Yes", description: "Have Proof of Residency", state_id: state.id, order_no: 0)
action2 = Action.new(name: "No/I don't know", description: "Don't have proof of residency", state_id: state.id, order_no: 1)

#Proof of residency FAQ
state = State.create(name: "Proof of Residency FAQ", description: "Proof of Residency FAQ", workflow_id: workflow.id, action_type_id: 3)
action2.next_state_id = state.id
action2.save # END for now, I have to save previous state ID to revert back

#US Citizen
state = State.create(name: "Check Citizenship", description: "Are you a U.S. Citizen?", workflow_id: workflow.id, action_type_id: 1)
action1.next_state_id = state.id
action1.save

action1_citizen = Action.new(name: "Yes", description: "Have US Citizenship", state_id: state.id, order_no: 0)
action2 = Action.new(name: "No", description: "Not US Citizen", state_id: state.id, order_no: 1)

#Immigration
state = State.create(name: "Check Immigration", description: "Are you a Qualified Immigrant? (e.g. Green Card)", workflow_id: workflow.id)
action2.next_state_id = state.id
action2.save

action1_imm = Action.create(name: "Yes", description: "Qualified Immigrant", state_id: state.id, order_no: 0) # Still to do!
action2_imm = Action.create(name: "No", description: "Not Immigrant", state_id: state.id, order_no: 1) # END

#Proof of US Citizen
state = State.create(name: "Check Proof Citizenship", description: "Do you have a proof of citizenship?", workflow_id: workflow.id, action_type_id: 1)
citizen_proof_state_id = state.id
action1_citizen.next_state_id = citizen_proof_state_id
action1_citizen.save

action1_proof = Action.new(name: "Yes", description: "Have US Citizen proof", state_id: state.id, order_no: 0)
action2 = Action.new(name: "No/I don't know", description: "Don't have US Citizen proof", state_id: state.id, order_no: 1)
action2.save

#Proof of US Citizen
state = State.create(name: "Proof Citizenship FAQ", description: "Proof Citizenship FAQ", workflow_id: workflow.id, action_type_id: 4)
action2.next_state_id = state.id
action2.save

action1 = Action.new(name: "Issue Resolved", description: "Have US Citizen proof", state_id: state.id)
action1.next_state_id = citizen_proof_state_id 
action1.save

action2 = Action.new(name: "Still have problem", description: "Don't have US Citizen proof", state_id: state.id)
action2.save

#Are you disabled?
state = State.create(name: "Check Disability", description: "Are you disabled?", workflow_id: workflow.id, action_type_id: 1)
action1_proof.next_state_id = state.id
action1_proof.save

action1 = Action.create(name: "Yes", description: "Disable", state_id: state.id, order_no: 0) # END
action2 = Action.new(name: "No", description: "Not Disable", state_id: state.id, order_no: 1)

# Checking income and number of people in the family
state = State.create(name: "Check Medicaid", 
				description: "Please enter the following information to determine if you are eligible:",
				workflow_id: workflow.id,
				form_name: "show_input_medicaid", form_param: "", action_type_id: 2)
action2.next_state_id = state.id
action2.save



