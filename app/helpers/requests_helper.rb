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
		elsif status == "Closed"
			outputColor = "danger"
		else
			outputColor = "success"
		end
	end

	def target_demo_req_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Target Demo" data-content="Who will this request primarily benefit?"> </i>')
	end
	def other_funding_req_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Other Funding" data-content="Mark this if we are not the only provider of funding. In that case, also please indicate your total budget."> </i>')
	end
	def detailed_description_req_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Detailed Description" data-content="Please provide a more detailed desription of this project, the community served, and what our funds will help with."> </i>')
	end
end