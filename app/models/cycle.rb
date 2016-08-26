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


  def self.open_close_cycles
    date_time_now = Time.now

    Cycle.all.each do |thisCycle|
      thisOpenDate = thisCycle.open
      thisCloseDate = thisCycle.close
      thisStatus = thisCycle.status

      if (thisStatus == 'Planned') && (thisOpenDate < date_time_now)
        thisCycle.update(status:"Open")
        #FIXME: Need better debug message
        Rails.logger.debug "Cycle has been opened"
      elsif (thisStatus == 'Open') && (thisCloseDate < date_time_now)
        thisCycle.update(status:"Closed")
        #FIXME: Need better debug message
        Rails.logger.debug "Cycle has been closed"
      end
    end
  end

end
