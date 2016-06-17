class Project
  include Mongoid::Document
  # Associations
  has_many :question
  accepts_nested_attributes_for :question, :reject_if => :all_blank, :allow_destroy => true
  has_many :cycle
  accepts_nested_attributes_for :cycle, :reject_if => :all_blank, :allow_destroy => true
  
  # Data
  field :name, type: String
end
