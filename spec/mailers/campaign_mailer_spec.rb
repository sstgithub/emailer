require "rails_helper"

RSpec.describe CampaignMailer, type: :mailer do
  describe 'send_mail' do
    it 'should be able to use 1st email service (mailgun)' do
      recipient = double("recipient")

      allow(Recipient).to receive(:column_names)
        .and_return(["salutation", "last_name", "first_name"])
      allow(Recipient).to receive(:find).with(1).and_return(recipient)
      allow(recipient).to receive(:salutation).and_return("Mr.")
      allow(recipient).to receive(:first_name).and_return("FirstName")
      allow(recipient).to receive(:last_name).and_return("LastName")
      allow(recipient).to receive(:email_address).and_return("email.address")
      send_using_mailgun_api_assertions("email.address", "body", "subject")

      CampaignMailer.send_mail([1], 'subject', 'body').deliver_now
    end

    it 'should use 2nd email service (mandrill) if 1st one fails' do
      recipient = double("recipient")

      allow(Recipient).to receive(:column_names)
        .and_return(["salutation", "last_name", "first_name"])
      allow(Recipient).to receive(:find).with(1).and_return(recipient)
      allow(recipient).to receive(:salutation).and_return("Mr.")
      allow(recipient).to receive(:first_name).and_return("FirstName")
      allow(recipient).to receive(:last_name).and_return("LastName")
      allow(recipient).to receive(:email_address).and_return("email.address")
      send_using_mandrill_api_assertions("email.address", "body", "subject")

      CampaignMailer.send_mail([1], 'subject', 'body').deliver_now
    end

    it 'should replace all user variables in email body with correct text
      based on recipient column names and values' do

      body = "Hello |salutation| |last_name| or |first_name|"
      recipient = double("recipient")

      expect(Recipient).to receive(:column_names)
        .and_return(["salutation", "last_name", "first_name"])
      expect(Recipient).to receive(:find).with(1).and_return(recipient)
      expect(recipient).to receive(:salutation).and_return("Mr.")
      expect(recipient).to receive(:first_name).and_return("FirstName")
      expect(recipient).to receive(:last_name).and_return("LastName")
      expect(recipient).to receive(:email_address).and_return("email.address")

      send_using_mailgun_api_assertions("email.address", "Hello Mr. LastName or FirstName", "subject")

      CampaignMailer.send_mail([1], 'subject', body).deliver_now
    end

  end

  describe 'send email through API' do
    it 'for mailgun' do
      client = double("client")
      message_params = {from: 'sid@sidtantia.com',
                        to: 'to',
                        subject: 'subject',
                        text: 'text'}
      response = double("response")

      expect(Mailgun::Client).to receive(:new).with(ENV['MAILGUN_KEY']).and_return(client)
      expect(client).to receive(:send_message)
        .with(ENV['MAILGUN_DOMAIN'], message_params).and_return(response)
      allow(response).to receive(:to_h!)

      CampaignMailer.send_using_mailgun_api('to','text','subject').deliver_now
    end

    it 'for mandrill' do
      client = double("client")
      message_params = {from_email: "sid@sidtantia.com",
                        to: [
                          {
                            "type": "to",
                            "email": "email"
                          }
                        ],
                        subject: "subject",
                        text: "text"}

      expect(Mandrill::API).to receive(:new).with(ENV['MANDRILL_KEY']).and_return(client)
      expect(client).to receive(:messages).and_return(client)
      expect(client).to receive(:send).with(message_params, false)

      CampaignMailer.send_using_mandrill_api('email','text','subject').deliver_now
    end
  end

  def send_using_mailgun_api_assertions(to, text, subject)
    client = double("client", :get => ActiveSupport::HashWithIndifferentAccess.new({"items": [{"message": {"headers": {"message-id": "123"}}}]}))
    response = double({"id": "<123>"}, :to_h! => {"id": "<123>"})
    message_params = {from: 'sid@sidtantia.com',
                      to: to,
                      subject: subject,
                      text: text}
    allow(Mailgun::Client).to receive(:new).with(ENV['MAILGUN_KEY']).and_return(client)
    expect(client).to receive(:send_message)
      .with(ENV['MAILGUN_DOMAIN'], message_params).and_return(response)
    allow(response).to receive(:to_h!)
  end

  def send_using_mandrill_api_assertions(email, text, subject)
    client = double("client")
    message_params = {from_email: "sid@sidtantia.com",
                      to: [
                        {
                          "type": "to",
                          "email": email
                        }
                      ],
                      subject: subject,
                      text: text}

    allow(Mandrill::API).to receive(:new).with(ENV['MANDRILL_KEY']).and_return(client)
    expect(client).to receive(:messages).and_return(client)
    expect(client).to receive(:send).with(message_params, false)
  end
end
