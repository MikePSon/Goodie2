class Request
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
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
  field :description,             type: String
  field :summary,                 type: String
  field :begin_date,              type: Date
  field :end_date,                type: Date
  field :app_complete,            type: Boolean
  field :submitted_date,          type: DateTime

  field :amount_awarded,          type: Float
  field :awarded,                 type: Boolean
  field :rejected,                type: Boolean

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
