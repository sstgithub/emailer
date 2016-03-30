class CampaignSerializer < BaseSerializer
  attributes :campaign_name, :email_subject, :email_body, :sent, :updated_at

  has_many :recipients, serializer: RecipientSerializer
end
