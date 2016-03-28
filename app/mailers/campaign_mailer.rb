class CampaignMailer < ApplicationMailer
  require 'mailgun'
  require 'mandrill'
  #
  # default(
  #   from: "sid@sidtantia.com",
  #   replyto: "sid@sidtantia.com"
  # )

  def send_mail(recipient_ids, subject, body)
    responses = []
    recipient_keys = Recipient.column_names
    recipient_ids.each do |recipient_id|
      recipient = Recipient.find(recipient_id)
      #Replace all `|<variable name here>|` with actual variables for recipient.
      # Can make this better by sending in as |recipient.<var name>| and then
      # use regex to replace all |...| with #{...}??
      recipient_keys.each do |key|
        body.gsub!("|#{key}|", recipient[key].to_s)
      end
      # mailer_services = MailerService.all
      # mailer_services.each do |mailer_service|
      #   setup_email_account(mailer_service)
      #   binding.pry
      #   response = mail(to: recipient.email_address,
      #                   body: body,
      #                   content_type: "text/html",
      #                   subject: subject)
      #   break if response
      # end
      response = send_using_mailgun_api(recipient.email_address, body, subject)
      #TODO: brittle, could time out. Put all sending mail into background jobs.
      i = 0
      email_was_delivered = false
      until email_was_delivered || i == 5
        sleep(1)
        i += 1
        email_was_delivered = @mailgun_client.get(ENV["MAILGUN_DOMAIN"]+"/events", {event: "delivered"}).to_h["items"].map {|x| x["message"]["headers"]["message-id"]}.select {|id| id==response["id"][1...-1]}.count >= 1
      end
      unless email_was_delivered
        response = send_using_mandrill_api(recipient.email_address, body, subject)
      end
      responses << response
    end
    return responses
  end

  private

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

    # def setup_email_account(mailer_service)
    #   ActionMailer::Base.raise_delivery_errors = true
    #   settings = ActionMailer::Base.smtp_settings
    #   settings[:user_name] = mailer_service.username
    #   settings[:domain] ||= mailer_service.domain
    #   settings[:address] = mailer_service.address
    #   settings[:password] = mailer_service.password || ENV['SMTP_password']
    #   settings[:port] = mailer_service.port || 587
    # end

end
