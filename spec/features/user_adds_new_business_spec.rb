require 'spec_helper'

feature "User adds new business" do
  scenario "with authenticated user and valid inputs" do
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

  scenario "with authenticated user but missing inputs" do
    login
    click_link 'Add Business'
    fill_in('Name*', with: 'ABC Store')
    click_button('Add Business')
    expect(page).to have_content("can't be blank")
  end

  scenario "with unauthenticated user" do
    visit root_path
    click_link 'Add Business'
    expect(page).to have_content('Sorry you must be logged in')
  end
end
