class CreateCampaignsAndRecipients < ActiveRecord::Migration
  def change
    create_table :campaigns_recipients, id: false do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :recipient, index: true
    end
  end
end
