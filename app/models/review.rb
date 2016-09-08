class Review
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  # Associations
  belongs_to :request
  belongs_to :cycle
  belongs_to :project
  belongs_to :organization
  belongs_to :user
  
  # Data
  field :decision,          type: String
  field :explanation,		type: String
  field :review_complete,	type: Boolean
  
end
