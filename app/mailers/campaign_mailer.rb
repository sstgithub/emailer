class CampaignMailer < ApplicationMailer
  default(
    from: "sid@sidtantia.com",
    replyto: "sid@sidtantia.com"
  )

  def send_mail(recipient_ids, subject, body)
    recipient_keys = Recipient.column_names
    recipient_ids.each do |recipient_id|
      recipient = Recipient.find(recipient_id)
      #Replace all `|<variable name here>|` with actual variables for recipient.
      # Can make this better by sending in as |recipient.<var name>| and then
      # use regex to replace all |...| with #{...}??
      recipient_keys.each do |key|
        body.gsub!("|#{key}|", recipient[key].to_s)
      end
      mailer_services = MailerService.all
      mailer_services.each do |mailer_service|
        setup_email_account(mailer_service)
        binding.pry
        response = mail(to: recipient.email_address,
                        body: body,
                        content_type: "text/html",
                        subject: subject)
        break if response
      end
    end
    return true
  end

  private

    def setup_email_account(mailer_service)
      ActionMailer::Base.raise_delivery_errors = true
      settings = ActionMailer::Base.smtp_settings
      settings[:user_name] = mailer_service.username
      settings[:domain] ||= mailer_service.domain
      settings[:address] = mailer_service.address
      settings[:password] = mailer_service.password || ENV['SMTP_password']
      settings[:port] = mailer_service.port || 587
    end

end
