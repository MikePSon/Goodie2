module ProjectsHelper
  def mission_helper
  	raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Project Mission?" data-content="Two to three sentences about the goal of this project."> </i>')
  end
  def cycle_budget_helper
  	raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Cycle Budget?" data-content="What is the budget for this project on any given cycle?"> </i>')
  end
  def repeat_helper
  	raw('<i style="position:relative;top:1px; margin-left:5px" class="icon-question" data-container="body" data-toggle="popover" data-placement="right" data-title="Project Repeat?" data-content="How often do cycles of this project repeat themselves?"> </i>')
  end

  def project_repeat
    [
        ['Annual', 'Annual'],
        ['Semi-Annual', 'Semi-Annual'],
        ['Quarterly', 'Quarterly'],
        ['Monthly', 'Monthly'],
        ['Special', 'Special'],
        ['Other', 'Other'],
        ['N/A', 'N/A']
    ]
  end

end