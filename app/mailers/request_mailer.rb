class RequestMailer < ApplicationMailer
	default from: 'mike@goodie2.com'

	def applicant_request_complete(user, cycle, program, request)
    @user = user
    @cycle = cycle
    @program = program
    @request = request
    mail(:to => @user.email,
      :subject => 'We received your request!' )
  end

end