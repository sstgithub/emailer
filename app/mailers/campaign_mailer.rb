class CampaignMailer < ApplicationMailer
  require 'mailgun'
  require 'mandrill'

  def send_mail(recipient_ids, subject, body)
    responses = []
    recipient_keys = Recipient.column_names
    recipient_ids.each do |recipient_id|
      recipient = Recipient.find(recipient_id)
      #Replace all `|<variable name here>|` with actual variables for recipient.
      # Can make this better by sending in as |recipient.<var name>| and then
      # use regex to replace all |...| with #{...}??
      recipient_keys.each do |key|
        body.gsub!("|#{key}|", recipient.send(key).to_s)
      end if body
      begin
        response = send_using_mailgun_api(recipient.email_address, body, subject)
      rescue Mailgun::Error => e
        response = send_using_mandrill_api(recipient.email_address, body, subject)
      end
      responses << response
    end
    return responses
  end

  def send_using_mailgun_api(to, text, subject)
    @mailgun_client = Mailgun::Client.new ENV['MAILGUN_KEY']
    message_params = {from: 'sid@sidtantia.com',
                      to: to,
                      subject: subject,
                      text: text}
    @mailgun_client.send_message(ENV['MAILGUN_DOMAIN'], message_params).to_h!
  end

  def send_using_mandrill_api(email, text, subject)
    @mandrill_client = Mandrill::API.new ENV['MANDRILL_KEY']
    message_params = {from_email: "sid@sidtantia.com",
                      to: [
                        {
                          "type": "to",
                          "email": email
                        }
                      ],
                      subject: subject,
                      text: text}
    async = false
    @mandrill_client.messages.send message_params, async
  end

end
