
class AdminMailer < ApplicationMailer
  default from: 'mike@goodie2.com'
 
  def cycle_open(cycle)
    @cycle = cycle
    @url  = 'http://example.com/login'
    mail(:to => @user.email,
    	:subject => 'Welcome to My Awesome Site')
  end
end