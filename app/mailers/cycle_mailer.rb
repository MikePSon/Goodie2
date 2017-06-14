class CycleMailer < ApplicationMailer
	default from: 'mike@goodie2.com'

	def admin_cycle_open(user, cycle, program)
    	@user = user
    	@cycle = cycle
    	@url  = 'http://example.com/login'
    	mail(:to => @user.email,
    		:subject => 'Time to do some good...')
  	end

  	def admin_cycle_closed(user, cycle, program)
    	@user = user
    	@cycle = cycle
    	@url  = 'http://example.com/login'
    	mail(:to => @user.email,
    		:subject => 'Review Time!')
  	end

  	def applicant_cycle_open(user, cycle, program)
    	@user = user
    	@cycle = cycle
    	@url  = 'http://example.com/login'
    	mail(:to => @user.email,
    		:subject => 'Time to do some good...')
  	end

  	def applicant_cycle_closed(user, cycle, program)
    	@user = user
    	@cycle = cycle
    	@url  = 'http://example.com/login'
    	mail(:to => @user.email,
    		:subject => 'Review Time!')
  	end
end