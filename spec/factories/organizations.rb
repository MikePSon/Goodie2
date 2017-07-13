# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :organization do
    name "Stripe Org"
    motto "Everybody wang chung tonight"
    url "www.espn.com"
    address1 "5148 Celtic Dr"
    address2 "Ste. 101"
    city "Charleston"
    zip "29405"
    giving_goal "2000000"
  end
end
