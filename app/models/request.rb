class Request
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  include Mongoid::Paperclip

  # Associations
  belongs_to :project
  belongs_to :cycle
  has_one :user
  has_one :organization
  has_many :review
  
  # Data
  field :status,                  type: String,   default: "Created"
  field :title,                   type: String
  field :amount_requested,        type: Float
  field :other_funding,           type: Boolean
  field :total_budget,            type: Float
  field :detailed_description,    type: String
  field :project_summary,         type: String
  field :project_start,           type: Date
  field :project_end,             type: Date
  field :app_complete,            type: Boolean
  field :submitted_date,          type: DateTime

  field :amount_awarded,          type: Float
  field :decision_made,           type: Boolean
  field :awarded,                 type: Boolean
  field :rejected,                type: Boolean

  #Standard Form Questions
  field :organization_name,       type: String
  field :organization_ein,        type: String
  field :org_address_1,           type: String
  field :org_address_2,           type: String
  field :org_city,                type: String
  field :org_state,               type: String
  field :org_zip,                 type: String
  field :org_mission,             type: String
  field :target_demo,             type: String
  has_mongoid_attached_file :form990_1
  validates_attachment_content_type :form990_1, :content_type => ["application/pdf","application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
             "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain"]
  has_mongoid_attached_file :form990_2
  validates_attachment_content_type :form990_2, :content_type => ["application/pdf","application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
             "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain"]
  has_mongoid_attached_file :form990_3
  validates_attachment_content_type :form990_3, :content_type => ["application/pdf","application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
             "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain"]
  has_mongoid_attached_file :board_chair_board_members

  #Fiscal Agent Questions
  field :fiscal_agent,            type: Boolean
  field :fiscal_agent_name,       type: String
  field :fiscal_agent_ein,        type: String



  # Validate Submitted Status
  before_save :check_submitted


  def self.close_incomplete_apps
    # May need refactoring...
    Cycle.where(:status => "Closed").each do |thisCycle|
      all_created_requests = Request.where(:cycle_id => thisCycle.id.to_s).where(:status => "Created")
      all_created_requests.each do |thisCreated|
        thisCreated.update(status:"Incomplete")
      end
    end
  end

  def self.review_complete_apps
    # May need refactoring...
    Cycle.where(:status => "Closed").each do |thisCycle|
      all_created_requests = Request.where(:cycle_id => thisCycle.id.to_s).where(:status => "Submitted")
      all_created_requests.each do |thisCreated|
        thisCreated.update(status:"Under Review")
      end
    end
  end

  protected
  def check_submitted
    if self.app_complete? && self.status == "Submitted"
      self.status = "Submitted"
      self.submitted_date = DateTime.now.in_time_zone
    end
  end


end
