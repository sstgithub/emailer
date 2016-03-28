require 'rails_helper'

feature 'User adds recipients to campaign' do
  before :each do
  end

  scenario 'and sends' do
    #expect(CampaignMailer).to receive(send_mail).with([1], "something", "something else")
    expect(ActionMailer::Base).to receive(:mail).with({to: 'testemail@email.com', body: 'body', content_type: 'text/html', subject: 'subject'})
    click_link "Send"

    expect(page).to have_css('.sent-campaign', count: 1, text: 'First')
  end

  scenario 'and cancels' do
    #expect(CampaignMailer).to not_receive(send_mail)
    expect(ActionMailer::Base).not_to receive(:mail)
    click_link "Cancel"

    expect(page).not_to have_css('sent-campaign')
  end
end
