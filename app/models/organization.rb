class Organization
  include Mongoid::Document
  include Mongoid::Paperclip
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

  field :custom_terms,              type: Boolean
  field :terms_conditions,          type: String

  has_mongoid_attached_file :logo, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  }
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end
