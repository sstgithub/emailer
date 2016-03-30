require 'rails_helper'

feature 'User creates campaign' do
  # before :each do
  #   visit "/"
  #   click_link "Add Campaign"
  #   select "email.address", from: "recipientSelect"
  #   fill_in "campaign_name", "Test Name"
  #   fill_in "email_body", "Test body"
  #   fill_in "email_subject", "Test subject"
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
  #   expect(page).not_to have_css('sent-campaign')
  # end
end
