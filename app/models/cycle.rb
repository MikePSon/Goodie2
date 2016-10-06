class Cycle
  include Mongoid::Document
  # Associations
  belongs_to :project
  has_many :request
  belongs_to :organization
  has_many :review

  # Data
  field :admin_note,            type: String
  field :instructions,          type: String
  field :name, 					        type: String
  field :status,				        type: String
  field :open,                  type: DateTime
  field :close,                 type: DateTime
  field :created_at,            type: DateTime, default: DateTime.now
  field :one_application,       type: Boolean, default: true

  #Basic Level, Questions Asked
    # Request Basics
    field :amount_requested,    type: Boolean
    field :project_summary,     type: Boolean
    field :project_start,       type: Boolean
    field :project_end,         type: Boolean

    #Organization
    field :organization_name,   type: Boolean
    field :ein_taxID,           type: Boolean
    field :org_address_1,       type: Boolean
    field :org_address_2,       type: Boolean
    field :org_city,            type: Boolean
    field :org_state,           type: Boolean
    field :org_zip,             type: Boolean
    field :org_mission,         type: Boolean

    #Request Details
    field :description,         type: Boolean
    field :other_funding,       type: Boolean
    field :total_budget,        type: Boolean
    field :target_demo,         type: Boolean


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
