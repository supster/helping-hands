class CreateProgramsServicesTable < ActiveRecord::Migration
  def up
    create_table :programs_services, :id => false do |t|
      t.references :program
      t.references :service
      
    end  
  end

  def down
  end
end
