json.extract! mailing_subscriber, :id, :first_name, :last_name, :email, :discount, :created_at, :updated_at
json.url mailing_subscriber_url(mailing_subscriber, format: :json)
