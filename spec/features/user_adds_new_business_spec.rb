require 'spec_helper'

feature "User adds new business" do
  scenario "with valid inputs" do
    login
    click_link 'Add Business'
    fill_in('Name*', with: 'ABC Store')
    fill_in('Address*', with: '10 A Street')
    fill_in('City*', with: 'Tokyo')
    fill_in('Country*', with: 'Japan')
    click_button('Add Business')
    expect(page).to have_content('ABC Store')
    click_link 'Business Index'
    expect(page).to have_content('ABC Store')
  end
end
