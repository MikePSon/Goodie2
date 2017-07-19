class ReleaseNote
  include Mongoid::Document
  field :release_date, 		type: Date
  field :note, 				type: String
  field :title, 			type: String
  field :release_type,		type: String
end
