require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  def admin_welcome
  	UserMailer.admin_welcome(User.first)
  end

  def applicant_welcome
  	UserMailer.applicant_welcome(User.first)
  end
end
