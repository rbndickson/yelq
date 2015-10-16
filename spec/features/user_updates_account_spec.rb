require 'spec_helper'

feature "User updates account info" do
  scenario "with valid inputs" do
    login
    click_link 'Account settings'
    fill_in('First name', with: 'Bob')
    fill_in('Password', with: 'password')
    click_button('Update')
    expect(page).to have_content('Bob')
  end
end
