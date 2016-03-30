require 'rails_helper'

RSpec.describe "Campaigns", type: :request do
  #TODO: use factory girl instead!
  before :all do
    Recipient.destroy_all
    Campaign.destroy_all
  end

  after :each do
    Recipient.destroy_all
    Campaign.destroy_all
  end

  describe "GET /campaigns" do
    it "returns all campaigns in JSONAPI format" do
      recipient = Recipient.create!(first_name: 'first name', last_name: 'last name', email_address: 'email@address.com')
      campaign = Campaign.create!(campaign_name: 'campaign name', email_body: 'email body', email_subject: 'email subject', recipient_ids: [Recipient.first.id])
      get campaigns_path

      expect(response).to have_http_status(200)

      campaigns = response_body["data"]
      expect(campaigns.count).to eq(1)
      #validate same as campaign in db and in JSONAPI format
      current_campaign = campaigns.first["attributes"]
      expect(current_campaign.keys).to eq(["campaign-name", "email-subject", "email-body", "sent", "updated-at"])
      expect(current_campaign["campaign-name"]).to eq(campaign["campaign_name"])
      expect(current_campaign["email-subject"]).to eq(campaign["email_subject"])
      expect(current_campaign["email-body"]).to eq(campaign["email_body"])
      expect(current_campaign["sent"]).to eq(campaign["sent"])
      expect(current_campaign["updated-at"].to_time.utc.to_s).to eq(campaign["updated_at"].utc.to_s)
    end
  end

  def response_body
    JSON.parse(response.body)
  end
end
