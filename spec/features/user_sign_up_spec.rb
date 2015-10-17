require 'spec_helper'

feature "User signs up" do
  scenario "with valid inputs" do
    visit root_path
    click_link 'Sign Up'
    fill_in('First name', with: 'Alice')
    fill_in('Last name', with: 'Alicia')
    fill_in('Email', with: 'alice@example.com')
    fill_in('Password', with: 'Password')
    click_button('Sign Up')
    expect(page).to have_content('You have been registered, please log in.')
  end

  scenario "with invalid inputs" do
    visit root_path
    click_link 'Sign Up'
    fill_in('First name', with: 'Alice')
    fill_in('Password', with: 'Pass')
    click_button('Sign Up')
    expect(page).to have_content('too short')
  end
end
