class Feature
  include Mongoid::Document
  field :name, type: String
  field :free_tier, type: Mongoid::Boolean
  field :paid_tier, type: Mongoid::Boolean
end
