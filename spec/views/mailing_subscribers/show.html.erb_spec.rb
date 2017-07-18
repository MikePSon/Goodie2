require 'rails_helper'

RSpec.describe "mailing_subscribers/show", type: :view do
  before(:each) do
    @mailing_subscriber = assign(:mailing_subscriber, MailingSubscriber.create!(
      :first_name => "First Name",
      :last_name => "Last Name",
      :email => "Email",
      :discount => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First Name/)
    expect(rendered).to match(/Last Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/false/)
  end
end
