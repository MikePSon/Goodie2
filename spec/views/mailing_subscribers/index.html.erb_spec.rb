require 'rails_helper'

RSpec.describe "mailing_subscribers/index", type: :view do
  before(:each) do
    assign(:mailing_subscribers, [
      MailingSubscriber.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :discount => false
      ),
      MailingSubscriber.create!(
        :first_name => "First Name",
        :last_name => "Last Name",
        :email => "Email",
        :discount => false
      )
    ])
  end

  it "renders a list of mailing_subscribers" do
    render
    assert_select "tr>td", :text => "First Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
