class Organization
  include Mongoid::Document
  # Associations
  has_many :users
  has_many :request
  has_many :project
  has_many :cycle
  has_many :review

  # Data
  field :name, 			type: String
  field :motto,			type: String
  field :created_by,	type: String
end
