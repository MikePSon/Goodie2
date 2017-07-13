# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    name "Project Name Text"
    mission "Ensure proper functionality"
    cycle_budget "50000"
  end
end
