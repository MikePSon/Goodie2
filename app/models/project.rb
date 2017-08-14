class Project
  include Mongoid::Document
  field :name, type: String
  field :annual_budget, type: String
  belongs_to :organization
  has_many :questions
  accepts_nested_attributes_for :questions, reject_if: :all_blank, allow_destroy: true

  field :mission,       type: String
  field :repeat_type,   type: String
  field :cycle_budget,  type: Float
  field :created_at,    type: DateTime, default: DateTime.now
  field :is_cycle, type: Boolean, default: false
  field :is_project,  type: Boolean, default: true

  field :project_string_1,         type: String
  field :project_string_2,         type: String
  field :project_string_3,         type: String
  field :project_string_4,         type: String
  field :project_string_5,         type: String
  field :project_string_6,         type: String
  field :project_string_7,         type: String
  field :project_string_8,         type: String
  field :project_string_9,         type: String
  field :project_string_10,        type: String
  field :project_boolean_1,        type: Boolean
  field :project_boolean_2,        type: Boolean
  field :project_boolean_3,        type: Boolean
  field :project_boolean_4,        type: Boolean
  field :project_boolean_5,        type: Boolean
  field :project_boolean_6,        type: Boolean
  field :project_boolean_7,        type: Boolean
  field :project_boolean_8,        type: Boolean
  field :project_boolean_9,        type: Boolean
  field :project_boolean_10,       type: Boolean
  field :project_date_1,           type: Date
  field :project_date_2,           type: Date
  field :project_date_3,           type: Date
  field :project_date_4,           type: Date
  field :project_date_5,           type: Date
  field :project_date_6,           type: Date
  field :project_date_7,           type: Date
  field :project_date_8,           type: Date
  field :project_date_9,           type: Date
  field :project_date_10,          type: Date
  field :project_datetime_1,       type: DateTime
  field :project_datetime_2,       type: DateTime
  field :project_datetime_3,       type: DateTime
  field :project_datetime_4,       type: DateTime
  field :project_datetime_5,       type: DateTime
  field :project_datetime_6,       type: DateTime
  field :project_datetime_7,       type: DateTime
  field :project_datetime_8,       type: DateTime
  field :project_datetime_9,       type: DateTime
  field :project_datetime_10,      type: DateTime
  field :project_time_1,           type: Time
  field :project_time_2,           type: Time
  field :project_time_3,           type: Time
  field :project_time_4,           type: Time
  field :project_time_5,           type: Time
  field :project_time_6,           type: Time
  field :project_time_7,           type: Time
  field :project_time_8,           type: Time
  field :project_time_9,           type: Time
  field :project_time_10,          type: Time


  field :project_integer_1,           type: Integer
  field :project_integer_2,           type: Integer
  field :project_integer_3,           type: Integer
  field :project_integer_4,           type: Integer
  field :project_integer_5,           type: Integer
  field :project_integer_6,           type: Integer
  field :project_integer_7,           type: Integer
  field :project_integer_8,           type: Integer
  field :project_integer_9,           type: Integer
  field :project_integer_10,          type: Integer
  field :project_float_1,           type: Float
  field :project_float_2,           type: Float
  field :project_float_3,           type: Float
  field :project_float_4,           type: Float
  field :project_float_5,           type: Float
  field :project_float_6,           type: Float
  field :project_float_7,           type: Float
  field :project_float_8,           type: Float
  field :project_float_9,           type: Float
  field :project_float_10,          type: Float



end
