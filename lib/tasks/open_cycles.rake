require 'rake'

namespace :cycles do
	desc 'Opens Cycles'
	task :open_cycles => :environment do
		Cycle.open_cycles
	end
end
