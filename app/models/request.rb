class Request
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
  # Associations
  belongs_to :project
  belongs_to :cycle
  has_one :user
  has_one :organization
  
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

  # Validate Submitted Status
  before_save :check_submitted

  protected
  def check_submitted
    if self.app_complete?
      self.status = "Submitted"
    end
  end

end
