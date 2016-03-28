class RecipientSerializer < BaseSerializer
  attributes :id, :email_address, :first_name, :last_name, :salutation

  has_many :campaigns, serializer: CampaignSerializer
end
