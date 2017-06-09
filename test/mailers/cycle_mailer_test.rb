require 'test_helper'


class CycleMailerTest < ActionMailer::TestCase
  def admin_cycle_open
  	@user = User.first
  	@cycle = Cycle.first
  	@project = Project.first
  	CycleMailer.admin_cycle_open(@user, @cycle, @project)
  end

  def admin_cycle_closed
  	@user = User.first
  	@cycle = Cycle.first
  	@project = Project.first
  	CycleMailer.admin_cycle_closed(@user, @cycle, @project)
  end
end
