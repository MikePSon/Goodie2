class Cycle
  include Mongoid::Document
  # Associations
  has_many :question
  accepts_nested_attributes_for :question, :reject_if => :all_blank, :allow_destroy => true
  belongs_to :project
  has_many :request
  belongs_to :organization

  # Data
  field :name, type: String
end
