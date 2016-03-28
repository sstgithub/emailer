require 'rails_helper'

RSpec.describe "MailerServices", type: :request do
  describe "GET /mailer_services" do
    it "works! (now write some real specs)" do
      get mailer_services_path
      expect(response).to have_http_status(200)
    end
  end
end
