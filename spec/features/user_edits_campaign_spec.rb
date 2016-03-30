require 'rails_helper'

feature 'User adds recipients to unsent campaign' do
  # before :each do
  #   #Recipient.create(email_address: "email.address", first_name: "Sid")
  #   #Campaign.create(campaign_name: "Test name", recipient_ids: [1], sent: false)
  #   visit "/"
  #   binding.pry
  # end
  #
  # after :each do
  #   Recipient.destroy_all
  #   Campaign.destroy_all
  # end
  #
  # scenario 'and saves for later' do
  #   click_link "Save for later"
  #   expect(page).to have_css('.unsent-campaign', count: 1, text: 'Test name')
  # end
  #
  # scenario 'and sends' do
  #   click_link "Send"
  #   expect(page).to have_css('.sent-campaign', count: 1, text: 'Test name')
  # end
  #
  # scenario 'and cancels' do
  #   click_link "Cancel"
  #   expect(page).to have_css('.unsent-campaign', count: 1, text: 'Test name')
  # end
end
