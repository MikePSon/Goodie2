require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def welcome_email
  	UserMailer.welcome_email(User.first)
  end
end
