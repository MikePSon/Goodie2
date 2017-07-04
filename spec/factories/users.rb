# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name 'ProgramAdmin'
    last_name 'TestQA'
    email 'example@example.com'
    password 'Goodie1@#qwe'
    password_confirmation 'Goodie1@#qwe'
    program_admin "true"
    # required if the Devise Confirmable module is used
    # confirmed_at Time.now
  end
end
