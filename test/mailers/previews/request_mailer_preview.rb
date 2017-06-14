# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class RequestMailerPreview < ActionMailer::Preview

	def applicant_request_complete
		RequestMailer.applicant_request_complete(User.first, Cycle.first, Project.first, Request.first)
	end

end
