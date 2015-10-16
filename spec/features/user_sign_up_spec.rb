require 'spec_helper'

feature "User adds new business" do
  scenario "with valid inputs" do
    visit root_path
    click_link 'Sign Up'
    fill_in('First name', with: 'Alice')
    fill_in('Last name', with: 'Alicia')
    fill_in('Email', with: 'alice@example.com')
    fill_in('Password', with: 'Password')
    click_button('Sign Up')
    expect(page).to have_content('You have been registered, please log in.')
    fill_in "email", with: 'alice@example.com'
    fill_in "password", with: 'Password'
    click_button "Log In"
    expect(page).to have_content('Alice')
  end
end
