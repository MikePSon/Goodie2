class Cycle
  include Mongoid::Document
  # Associations
  belongs_to :project
  has_many :request
  belongs_to :organization
  has_many :review

  # Data
  field :admin_note,        type: String
  field :name, 					    type: String
  field :status,				    type: String
  field :open,              type: DateTime
  field :close,             type: DateTime
  field :created_at,        type: DateTime, default: DateTime.now
  field :one_application,   type: Boolean, default: true

  # Field for timeline. Array contains multiple objects
  field :is_cycle,      type: Boolean, default: true
  field :is_project,    type: Boolean, default: false


  def self.open_close_cycles
    Rails.logger.debug "*********** OPEN/CLOSE CYCLES AUTO RUN ***********"
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
