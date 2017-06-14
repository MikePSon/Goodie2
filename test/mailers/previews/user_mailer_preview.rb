# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def admin_welcome
		UserMailer.admin_welcome(User.first)
	end

	def applicant_welcome
		UserMailer.applicant_welcome(User.first)
	end
end
