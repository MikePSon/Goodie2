class Organization
  include Mongoid::Document
  # Associations
  has_many :users
  has_many :request
  has_many :project
  has_many :cycle
  has_many :review

  # Data
  field :name,                      type: String
  field :motto,                     type: String
  field :url,                       type: String
  field :address_1,                 type: String
  field :address_2,                 type: String
  field :city,                      type: String
  field :state,                     type: String
  field :zip,                       type: String

  field :created_by,                type: String
  field :manager_decision,          type: Boolean
  field :manager_project_edit,      type: Boolean

  field :annual_giving_goal,        type: Integer
end
