require 'rails_helper'

RSpec.describe "mailing_subscribers/new", type: :view do
  before(:each) do
    assign(:mailing_subscriber, MailingSubscriber.new(
      :first_name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :discount => false
    ))
  end

  it "renders new mailing_subscriber form" do
    render

    assert_select "form[action=?][method=?]", mailing_subscribers_path, "post" do

      assert_select "input#mailing_subscriber_first_name[name=?]", "mailing_subscriber[first_name]"

      assert_select "input#mailing_subscriber_last_name[name=?]", "mailing_subscriber[last_name]"

      assert_select "input#mailing_subscriber_email[name=?]", "mailing_subscriber[email]"

      assert_select "input#mailing_subscriber_discount[name=?]", "mailing_subscriber[discount]"
    end
  end
end
