class Question
  include Mongoid::Document
  belongs_to :cycle
  belongs_to :project
  belongs_to :organization

	field :label, 						type: String
	field :type,  						type: String
	field :question_matcher,			type: String


end
