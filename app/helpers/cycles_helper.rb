module CyclesHelper
	def status_color status
		if status == "planned"
			outputColor = "info"
		elsif status == "Open"
			outputColor = "success"
		elsif status == "Closed"
			outputColor = "inverse"
		elsif status == "Re-Opened"
			outputColor = "danger"
		else
			outputColor = "warning"
		end
	end

	def app_status_indicator status
		if status == "Created"
			outputColor = "info"
		elsif status == "Submitted"
			outputColor = "success"
		elsif status == "Incomplete"
			outputColor = "danger"
		end
	end
end
