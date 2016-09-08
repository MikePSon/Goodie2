class Project
  include Mongoid::Document
  # Associations
  belongs_to :organization
  has_many :question
  accepts_nested_attributes_for :question, :reject_if => :all_blank, :allow_destroy => true
  has_many :cycle
  accepts_nested_attributes_for :cycle, :reject_if => :all_blank, :allow_destroy => true
  has_many :request
  has_many :review
  
  # Data
  field :name,              type: String
  field :mission,           type: String
  field :repeat_type,       type: String
  field :cycle_budget,      type: Float
end
