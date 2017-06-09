
class UserMailer < ApplicationMailer
  default from: 'mike@goodie2.com'
 
  def welcome_email(user)
    @user = user
    @url  = 'http://example.com/login'
    mail(:to => @user.email,
    	:subject => 'Welcome to Goodie2!')
  end
end