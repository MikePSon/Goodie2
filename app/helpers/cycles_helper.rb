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

	#Request Form Helpers
	def org_name_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Organization Name" data-content="Will display a small text field for the applicant to enter the name of their organiaztion."> </i>')
	end
	def org_ein_taxID_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="EIN/Tax ID" data-content="Will display a small text field for the applicant to enter the name of their EIN or Tax ID."> </i>')
	end
	def org_address_1_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Address 1" data-content="Will display a small text field for the applicant to enter their primary address."> </i>')
	end
	def org_address_2_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Address 2" data-content="Will display a small text field for the applicant to enter a secondary address."> </i>')
	end
	def org_city_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="City" data-content="Will display a small text field for the applicant to enter the city they are located in."> </i>')
	end
	def org_state_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="State" data-content="Will display a dropdown containing the 50 US States, Washington DC, and Puerto Rico."> </i>')
	end
	def org_zip_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Zip" data-content="Will display a small text field for the applicant to enter their zip code"> </i>')
	end
	def org_mission_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Mission" data-content="Will display a larger text area field for the applicant to enter their organizations mission statement"> </i>')
	end
	def form990_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Form 990" data-content="Will display 3 upload fields to upload the previous 3 Form 990s."> </i>')
	end

	def target_demo_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Target Demo" data-content="Will display a larger text area field for the applicant to enter a describe the community they will be serving."> </i>')
	end
	def project_objective_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Project Objective" data-content="Will display a larger text area field for the applicant to enter a describe their project, the goals, and desired outcomes."> </i>')
	end
	def amount_requested_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Amount Requested" data-content="Some foundations only donate set amounts, this field allows the applicants to request an amount specific to their project."> </i>')
	end
	def instructions_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Instructions" data-content="At the beginning of the application this will display a set of instructions for the applicant."> </i>')
	end
	def detailed_description_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Detailed Description" data-content="Diplay a larger text field, allowing the applicant to provide more detail on their project."> </i>')
	end
	def project_start_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Project Start" data-content="Display a date field for users to indicate when they wish to begin their project."> </i>')
	end
	def project_end_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Project End" data-content="Display a date field for users to indicate when their project will end."> </i>')
	end
	def other_funding_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Other Funding" data-content="Some projects have multiple sources of funding. Will display a true/false indicator. If the user elects true, will also display a Total Budget field."> </i>')
	end
	def board_members_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Board Chair & Members" data-content="Will display a file upload for the user to upload the Board Chair & Board Members of their organization."> </i>')
	end
end
