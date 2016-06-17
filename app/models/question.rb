class Question
  include Mongoid::Document
  # Associations
  belongs_to :project
  belongs_to :cycle
  
  # Data
  field :label, type: String
end
