require 'rake'

namespace :cycles do
	desc 'Opens and closes cycles'
	task :open_close_cycles => :environment do
		Cycle.open_close_cycles
	end
end
