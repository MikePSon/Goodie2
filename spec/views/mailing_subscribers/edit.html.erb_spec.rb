require 'rails_helper'

RSpec.describe "mailing_subscribers/edit", type: :view do
  before(:each) do
    @mailing_subscriber = assign(:mailing_subscriber, MailingSubscriber.create!(
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :discount => false
    ))
  end

  it "renders the edit mailing_subscriber form" do
    render

    assert_select "form[action=?][method=?]", mailing_subscriber_path(@mailing_subscriber), "post" do

      assert_select "input#mailing_subscriber_first_name[name=?]", "mailing_subscriber[first_name]"

      assert_select "input#mailing_subscriber_last_name[name=?]", "mailing_subscriber[last_name]"

      assert_select "input#mailing_subscriber_email[name=?]", "mailing_subscriber[email]"

      assert_select "input#mailing_subscriber_discount[name=?]", "mailing_subscriber[discount]"
    end
  end
end
