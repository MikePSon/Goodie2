
class UserMailer < ApplicationMailer
  default from: 'mike@goodie2.com'
 
  def admin_welcome(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(:to => @user.email,
    	:subject => 'Welcome to Goodie2!')
  end

  def applicant_welcome(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(:to => @user.email,
    	:subject => 'Welcome to Goodie2!')
  end
end