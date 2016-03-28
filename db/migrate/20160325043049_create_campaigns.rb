class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :campaign_name
      t.string :email_subject
      t.text :email_body

      t.timestamps null: false
    end
  end
end
