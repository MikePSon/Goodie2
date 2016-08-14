class Request
  include Mongoid::Document
  # Associations
  belongs_to :project
  belongs_to :cycle
  belongs_to :user
  belongs_to :organization
  
  # Data
  field :title, type: String
  field :amount_requested, type: Float
  field :other_funding, type: Boolean
  field :total_budget, type: Float
  field :description, type: String
  field :summary, type: String
  field :begin_date, type: Date
  field :end_date, type: Date
  

end
