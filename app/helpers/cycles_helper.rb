module CyclesHelper
	def one_application_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="One Application?" data-content="Does your program only allow an applicant to apply once per cycle?"> </i>')
	end

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
