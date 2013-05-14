# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
	
["Education", "Work", "Health", "Food", "Housing", "Money", "Child Care"].each do |a|
  Area.find_or_create_by_name(a)
end
Workflow.delete_all
State.delete_all
Action.delete_all

area_id = Area.find_by_name("Education").id
#Education - Finish Highschool
workflow = Workflow.create(name: "Finishing High School", 
						 description: "I need help staying in school or getting a GED.", area_id: area_id)

state = State.create(name: "Check age", description: "Are you 21 or older?", workflow_id: workflow.id)
workflow.start_state_id = state.id
workflow.save

action1 = Action.new(name: "Yes", description: "Older than 21", state_id: state.id)
action2 = Action.new(name: "No", description: "Younger than 21", state_id: state.id)

# Older than 21
state = State.create(name: "Adult Learning Programs", 
			description: "GED preparation classes can help you reach your goal!<br> 
						 Please contact one of these program centers near you:",
			workflow_id: workflow.id,
			form_name: "show_programs", form_param: "Adult GED")
action1.next_state_id = state.id
action1.save

action3 = Action.create(name: "contact Programs", state_id: state.id, 
						description: "Adult Education Programs")

# Younger than 21
state = State.create(name: "High School Alternatives", 
				description: "You are in luck! There are a lot of programs that can help you such as 
						 Transfer Schools, Young Adult Borough Centers (YABCs), or GED Plus. 
						 Please contact one of these referral centers near you for more information:",
				workflow_id: workflow.id,
				form_name: "show_programs", form_param: "High School Alternatives")
action2.next_state_id = state.id
action2.save

action3 = Action.create(name: "Contact Program", state_id: state.id, 
						description: "High School Alternatives Program")

#Education - Improve my English
workflow = Workflow.create(name: "Improving my English", 
						 description: "I want to take English classes.", area_id: area_id)


#Education - Learn career and technical skills
workflow = Workflow.create(name: "Learning new skills", 
						 description: "I want to learn career and technical skills.", area_id: area_id)

