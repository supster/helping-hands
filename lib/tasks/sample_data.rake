require 'csv'

namespace :db do
 desc "upload CSV data" 
 task populate: :environment do
    Agency.delete_all
    Program.delete_all
    ProgramCriteria.delete_all
    Location.delete_all

    ["high school", "health insurance", "job and internship", "english"].each do |a|
      Service.find_or_create_by_name(a)
    end

    make_agency
    #make_GED "#{Rails.root}/lib/tasks/GED_service.csv", 1
    #make_Work "#{Rails.root}/lib/tasks/Workforce_1_Career_Center_Locations3.csv", 2
    #make_courses
    #make_reviews
 end
 
 #populate
 def make_agency
    agency = Agency.create!(name: "District 79 - NYC Department of Education")
    service = Service.find_by_name("high school")
    program = service.programs.create!(name: "Alternative Schools & Programs", agency_id: agency.id,
                            url: "http://schools.nyc.gov/ChoicesEnrollment/AlternativesHS/Referral/default.htm")
    program.program_criterias.create!(name: "check age", value: "age:<21")
    make_agency_locations(agency.id, "#{Rails.root}/lib/tasks/Referral_Centers_For_High_School_Alternatives.csv")

    agency = Agency.create!(name: "Office of Adult & Continuing Education")
    program = service.programs.create!(name: "High School Equivalency (GED)", agency_id: agency.id,
                            url: "http://schools.nyc.gov/ChoicesEnrollment/AdultEd/ProgramOfferings/default.htm")
    program.program_criterias.create!(name: "check age", value: "age:>=21")
    make_agency_locations(agency.id, "#{Rails.root}/lib/tasks/OACE.csv")

    agency = Agency.create!(name: "New York Medicaid")
    service = Service.find_by_name("health insurance")
    program = service.programs.create!(name: "Adult Medicaid", agency_id: agency.id,
                            url: "http://www.health.ny.gov/health_care/medicaid/")
    #program.program_criterias.create!(name: "check age", value: "age:19-65")
    #program.program_criterias.create!(name: "check age", value: "age:>65")
    make_agency_locations(agency.id, "#{Rails.root}/lib/tasks/Medical_Assistance_Program_Medicaid_Offices.csv")   

    agency = Agency.create!(name: "Public Health Insurance")
    program = service.programs.create!(name: "Family Health Plus", agency_id: agency.id,
                            url: "http://www.health.ny.gov/health_care/family_health_plus/")
    #program.program_criterias.create!(name: "check age", value: "age:19-65")
    #program.program_criterias.create!(name: "check age", value: "age:>65")
    make_agency_locations(agency.id, "#{Rails.root}/lib/tasks/Public_Health_Insurance_Enrollment_Sites.csv")   

    program = service.programs.create!(name: "Child Health Plus", agency_id: agency.id,
                            url: "http://www.health.ny.gov/health_care/child_health_plus/")
    #program.program_criterias.create!(name: "check age", value: "age:19-65")
    #program.program_criterias.create!(name: "check age", value: "age:>65")
    #make_agency_locations(agency.id, "#{Rails.root}/lib/tasks/Public_Health_Insurance_Enrollment_Sites.csv")   
 end

 def make_agency_locations(agency_id, filename)
    csv_contents = CSV.parse(File.read(filename), {:converters => :all, headers: true} ) do |row|
    location = Location.new(agency_id: agency_id, name: row[0], address: row[1], city: row[2], 
                         state: row[3], zip: row[4], phone: row[5], latitude: row[7], longitude: row[8])
    if location.valid?
      location.save
    else
      location.errors.inspect
    end
 end

 def make_program_criteria(program, name, value)
   program.create!(name: name, value: value)
 end

=begin
 def make_GED(filename, service_type)
    csv_contents = CSV.parse(File.read(filename), {:converters => :all, headers: true} ) do |row|
    service = Service.new(name: row[0], address: row[1], city: row[2], 
                         state: "NY", phone: row[3], description: "",
                         url: row[5], service_type: service_type)
    if service.valid?
      service.save
    else
      service.errors.inspect
    end
  end
 end

 def make_Work(filename, service_type)
    csv_contents = CSV.parse(File.read(filename), {:converters => :all, headers: true} ) do |row|
    service = service.new(name: row[0], address: row[1], city: row[2], zip_code: row[3],
                         state: "NY", phone: row[4], url: row[5], service_type: service_type,
                         description: "Workforce and career training program")
    if service.valid?
      service.save
    else
      service.errors.inspect
    end
  end
=end
 end
end