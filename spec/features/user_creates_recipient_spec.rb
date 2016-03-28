require 'rails_helper'

feature 'User creates a recipient' do
  before :each do
    visit "/" 
    binding.pry
    click_link 'Add Recipient'
    fill_in 'salutation', with: 'Mr.'
    fill_in 'first_name', with: 'John'
    fill_in 'last_name', with: 'Smith'
    fill_in 'email_address', with: 'johnsmith@testemail.com'
  end

  scenario 'and saves' do
    click_link 'Save'

    expect(page).to have_css('.recipient', count: 1, text: 'Mr. John Smith, johnsmith@testemail.com')
  end

  scenario 'and cancels' do
    click_link 'Cancel'

    expect(page).not_to have_css('.recipient')
  end
end
