module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Goodie2"
    end
  end

  def cycle_statuses
    [
        ['Planned', '1', 'Planned'], ['Open', '2', 'Open'], ['Closed', '3', 'Closed'],
        ['Re-Opened', '4', 'Re-Opened'], ['Paused', '5', 'Paused']
    ]
  end

  def genders
    [ ['Male'], ['Female'], ['Other'], ['Prefer not to say'] ]
  end

  def races
    [ ['White'], ['Hispanic, Latino, Spanish Origin'], ['Black or African American'], ['American Indian, Alaska Native'],
      ['Middle Eastern, North African'], ['Native Hawaiian, Pacific Islander'], ['Two or more races'], ['Other']]
  end

  def request_statuses
    [
        ['Created','1', 'Created'], ['In Progress','2', 'In Progress'],
        ['Submitted','3', 'Submitted'], ['Incomplete','4', 'Incomplete'],
        ['Re-Opened','5', 'Re-Opened'], ['Under Review','6', 'Under Review'],
        ['Closed','7', 'Closed'], ['Awarded','8', 'Awarded'],['Payment','9', 'Payment'],
        ['Project Complete','10', 'Project Complete']
    ]
  end

  def us_states
  	[
    	['Alabama', 'AL'], ['Alaska', 'AK'], ['Arizona', 'AZ'], ['Arkansas', 'AR'],
    	['California', 'CA'], ['Colorado', 'CO'], ['Connecticut', 'CT'],
    	['Delaware', 'DE'], ['District of Columbia', 'DC'], ['Florida', 'FL'],
    	['Georgia', 'GA'], ['Hawaii', 'HI'], ['Idaho', 'ID'], ['Illinois', 'IL'],
    	['Indiana', 'IN'], ['Iowa', 'IA'], ['Kansas', 'KS'], ['Kentucky', 'KY'],
    	['Louisiana', 'LA'], ['Maine', 'ME'], ['Maryland', 'MD'], ['Massachusetts', 'MA'],
    	['Michigan', 'MI'], ['Minnesota', 'MN'], ['Mississippi', 'MS'], ['Missouri', 'MO'],
    	['Montana', 'MT'], ['Nebraska', 'NE'], ['Nevada', 'NV'], ['New Hampshire', 'NH'],
    	['New Jersey', 'NJ'], ['New Mexico', 'NM'], ['New York', 'NY'], 
        ['North Carolina', 'NC'], ['North Dakota', 'ND'], ['Ohio', 'OH'], ['Oklahoma', 'OK'],
    	['Oregon', 'OR'], ['Pennsylvania', 'PA'], ['Puerto Rico', 'PR'],
    	['Rhode Island', 'RI'], ['South Carolina', 'SC'], ['South Dakota', 'SD'],
    	['Tennessee', 'TN'], ['Texas', 'TX'], ['Utah', 'UT'], ['Vermont', 'VT'],
    	['Virginia', 'VA'], ['Washington', 'WA'], ['West Virginia', 'WV'],
    	['Wisconsin', 'WI'], ['Wyoming', 'WY']
    ]
  end

  def controller?(*controller)
    controller.include?(params[:controller])
  end

  def action?(*action)
    action.include?(params[:action])
  end

  def progress_indicator(amount)
    if amount <= 59
      outputColor = "danger"
    elsif amount > 59 && amount <= 69
      outputColor = "warning"
    elsif amount > 69 && amount <= 79
      outputColor = "primary"
    elsif amount > 79 && amount <= 89
      outputColor = "info"
    else
      outputColor = "success"
    end
  end
  def progress_hex(amount)
    if amount <= 59
      output_hex = "#F05050"
    elsif amount > 59 && amount <= 69
      output_hex = "#FF902B"
    elsif amount > 69 && amount <= 79
      output_hex = "#5D9CEC"
    elsif amount > 79 && amount <= 89
      output_hex = "#23B7E5"
    else
      output_hex = "#27C24C"
    end
  end

  def get_icon(param)
    param = param.downcase
    if param == "organization"
      return "fa fa-building-o"
    elsif param == "project"
      return "fa fa-file-text-o"
    elsif param == "cycle"
      return "icon-refresh"
    elsif param == "request"
      return "icon-note"
    elsif param == "dashboard"
      return "icon-speedometer"
    elsif param == "edit"
      return "fa fa-gears"
    elsif param == "logout"
      return "icon-power"
    end
  end#End get_icon
end