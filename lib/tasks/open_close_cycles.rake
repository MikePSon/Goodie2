require 'rake'

namespace :cycles do
	desc 'Opens and closes cycles'
	task :open_close_cycles => :environment do
		Cycle.open_close_cycles
		Request.close_incomplete_apps
		Request.review_complete_apps
	end
end
