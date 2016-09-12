module OrganizationsHelper
	def manager_decision_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="PM Decision?" data-content="Can your program managers make final accept/reject decisions?"> </i>')
	end
	def manager_project_edit_helper
		raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="PM Edit?" data-content="Can your program managers edit projects?"> </i>')
	end
end
