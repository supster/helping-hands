class UserCase < ActiveRecord::Base
  attr_accessible :id
  has_many :case_workflow_values
  before_save :create_case_token

  private 
  def create_case_token
    self.case_token = SecureRandom.urlsafe_base64  
  end

end
