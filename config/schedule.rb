require 'logger'
# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#

set :output, {
	:standard => 'log/cron_log.log'
}
require File.expand_path(File.dirname(__FILE__) + "/environment")
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 15.minutes do
	Rails.logger = Logger.new(STDOUT)
	rake "cycles:open_close_cycles", :environment => "development", :output => "log/cron_log.log"
end
