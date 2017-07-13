### Top Lvl Functions
def applicant_sign_up
  org_ID = Organization.where(:name => "Stripe Org").first.id.to_s
  url_string = 'http://localhost:3000/new_applicant?organization_id=' + org_ID
  visit url_string
  save_and_open_page
end

def stripe_sign_up
  visit '/users/sign_up'
  stripe_fill_user_fields
end

def stripe_create_organization
  expect(page).to have_content "setup your organization within Goodie"
  click_link "new_org"
  stripe_fill_org_fields
end

def stripe_create_project
  expect(page).to have_content "The next step is to create some projects."
  click_link "new_project"
  stripe_fill_project_fields
end

def stripe_create_cycle
  expect(page).to have_content "Let's talk more about cycles"
  click_link "create_cycle"
  stripe_fill_cycle_fields
end


### Document Templates
def stripe_user_template
  @visitor ||= { :first_name => "Striped", :last_name => "Tester", :email => "stripeduser@qatest.com",
    :password => "123qwe", :password_confirmation => "123qwe", :stripeid => "cus_Ay7hvc5tHtO998",
    :planid => "1000" }
end

def applicant_template
  @visitor ||= { :first_name => "Applicant", :last_name => "Tester", :email => "applicant@qatest.com",
    :password => "123qwe", :password_confirmation => "123qwe" }
end

def stripe_org_template
  @organization ||= { :name => "Stripe Org", :motto => "Everybody wang chung tonight", :url => "www.espn.com",
    :address_1 => "5148 Celtic Dr", :address_2 => "Ste. 101", :city => "Charleston", :zip => "29405",
    :giving_goal => "2000000"}
end

def stripe_project_template
  @project ||= { :name => "Project Name Text", :mission => "Ensure proper functionality", :cycle_budget => "50000"}
end

def stripe_cycle_template
  @cycle ||= { :name => "Stripe Org", :open => "01 Jul 2020 09:00 AM", :close => "31 Jul 2020 05:00 PM",
    :instruction => "Admin instructions to applicant", :admin_note => "Admin internal note"}
end

### Form Fillers
def stripe_fill_user_fields
  stripe_user_template
  fill_in "signupInputFirstName", :with => @visitor[:first_name]
  fill_in "signupInputLastName", :with => @visitor[:last_name]
  fill_in "signupInputEmail", :with => @visitor[:email]
  fill_in "user_password", :with => @visitor[:password]
  fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
  # Hacks Stipe Registration for testing
  fill_in "user_stripeid", :with => @visitor[:stripeid]
  fill_in "user_planid", :with => @visitor[:planid]
  click_button "submit_button"
end

def stripe_fill_org_fields
  stripe_org_template
  fill_in "organization_name", :with => @organization[:name]
  fill_in "organization_motto", :with => @organization[:motto]
  fill_in "organization_url", :with => @organization[:url]
  click_button "submit_org"
end

def stripe_fill_project_fields
  expect(page).to have_content "New Project"
  stripe_project_template
  fill_in "project_name", :with => @project[:name]
  fill_in "project_mission", :with => @project[:mission]
  fill_in "project_cycle_budget", :with => @project[:cycle_budget]
  click_button "create_project"
end

def stripe_fill_cycle_fields
  expect(page).to have_content "New Cycle"
  stripe_cycle_template
  #Basic fields
  fill_in "cycle_name", :with => @cycle[:name]
  fill_in "cycle_open", :with => @cycle[:open]
  fill_in "cycle_close", :with => @cycle[:close]
  click_link "Next"

  #fill_in "cycle_instructions", :with => @cycle[:instructions]
  click_link "Next"

  page.evaluate_script("$('#cycle_organization_name').prop('checked', true)")
  page.evaluate_script("$('#cycle_ein_taxID').prop('checked', true)")
  page.evaluate_script("$('#cycle_org_address_1').prop('checked', true)")
  page.evaluate_script("$('#cycle_org_address_2').prop('checked', true)")
  page.evaluate_script("$('#cycle_form990').prop('checked', true)")
  page.evaluate_script("$('#cycle_org_city').prop('checked', true)")
  page.evaluate_script("$('#cycle_org_state').prop('checked', true)")
  page.evaluate_script("$('#cycle_org_zip').prop('checked', true)")
  page.evaluate_script("$('#cycle_org_mission').prop('checked', true)")
  page.evaluate_script("$('#cycle_board_members').prop('checked', true)")
  click_link "Next"

  page.evaluate_script("$('#cycle_target_demo').prop('checked', true)")
  page.evaluate_script("$('#cycle_project_summary').prop('checked', true)")
  page.evaluate_script("$('#cycle_amount_requested').prop('checked', true)")
  page.evaluate_script("$('#cycle_description').prop('checked', true)")
  page.evaluate_script("$('#cycle_project_start').prop('checked', true)")
  page.evaluate_script("$('#cycle_project_end').prop('checked', true)")
  page.evaluate_script("$('#cycle_other_funding').prop('checked', true)")
  click_link "Next"

  #fill_in "cycle_admin_note", :with => @cycle[:admin_note]

  click_button "create_cycle"
end

Given /^I am a striped user$/ do
  stripe_sign_up
  stripe_create_organization
  stripe_create_project
  stripe_create_cycle
  expect(page).to have_content "Check out your cycle"
end

And /^I open a cycle early$/ do
  click_link "cycle_tab"
  click_button "Open"
end

And /^I close the cycle$/ do
  
  click_link "cycle_tab"
  click_button "Close"
end

And /^applicants should be able to apply$/ do
  applicant_sign_up
end

Then /^I should receive an successful update notice$/ do
  expect(page).to have_content "Cycle was successfully updated"
end