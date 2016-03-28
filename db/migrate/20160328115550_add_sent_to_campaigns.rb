class AddSentToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :sent, :boolean
  end
end
