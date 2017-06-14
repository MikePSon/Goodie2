require 'test_helper'


class RequestMailerTest < ActionMailer::TestCase
  def applicant_request_complete
  	@user = User.first
  	@cycle = Cycle.first
  	@project = Project.first
    @request = Request.first
  	RequestMailer.applicant_request_complete(@user, @cycle, @project, @request)
  end

end
