module OrganizationsHelper
	def manager_decision_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="PM Decision?" data-content="Can your program managers make final accept/reject decisions?"> </i>')
	end
	def manager_project_edit_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="PM Edit?" data-content="Can your program managers edit projects?"> </i>')
	end
	def annual_giving_goal_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Giving Goal?" data-content="Track if your on target to give what you can!"> </i>')
	end
	def custom_terms_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Custom Terms?" data-content="Your applicants must accept our terms and conditions to register. If you would like to insert your own as well, check this!"> </i>')
	end
end
