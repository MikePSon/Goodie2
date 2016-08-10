class Request
  include Mongoid::Document
  # Associations
  belongs_to :project
  belongs_to :cycle
  
  # Data
  field :amount_requested, type: Float



end
