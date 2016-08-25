class Cycle
  include Mongoid::Document
  # Associations
  has_many :question
  accepts_nested_attributes_for :question, :reject_if => :all_blank, :allow_destroy => true
  belongs_to :project
  has_many :request
  belongs_to :organization

  # Data
  field :name, 					type: String
  field :status,				type: String
  field :open,          type: DateTime
  field :close,         type: DateTime


  def self.open_cycles
    date_time_now = Time.now
    Cycle.all.each do |thisCycle|
      thisOpenDate = thisCycle.open
      thisStatus = thisCycle.status
      if (thisOpenDate < date_time_now) && (thisStatus == 'Planned')
        Rails.logger.debug '***************************Open has passed***************************'
        thisCycle.update(status:"Open")
      elsif thisStatus == 'Planned'
        Rails.logger.debug '***************************Cycle is planned***************************'
      else
        Rails.logger.debug '***************************Open is coming***************************'
      end
    end
  end

end
