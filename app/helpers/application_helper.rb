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
end
