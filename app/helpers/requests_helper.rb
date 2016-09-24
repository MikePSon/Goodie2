module RequestsHelper
	def request_color status
		if status == "Created"
			outputColor = "info"
		elsif status == "Submitted"
			outputColor = "success"
		elsif status == "Incomplete"
			outputColor = "inverse"
		elsif status == "Re-Opened"
			outputColor = "danger"
		elsif status == "Under Review"
			outputColor = "warning"
		elsif status == "Payment"
			outputColor = "success"
		else
			outputColor = "success"
		end
	end
end