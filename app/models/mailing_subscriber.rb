class MailingSubscriber
  include Mongoid::Document
  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :discount, type: Mongoid::Boolean

  validates :email, uniqueness: true
end
