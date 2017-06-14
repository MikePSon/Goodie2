# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class CycleMailerPreview < ActionMailer::Preview
	def admin_cycle_open
		CycleMailer.admin_cycle_open(User.first, Cycle.first, Project.first)
	end
	def admin_cycle_closed
		CycleMailer.admin_cycle_closed(User.first, Cycle.first, Project.first)
	end

	def applicant_cycle_open
		CycleMailer.applicant_cycle_open(User.first, Cycle.first, Project.first)
	end
	def applicant_cycle_closed
		CycleMailer.applicant_cycle_closed(User.first, Cycle.first, Project.first)
	end
end
