require 'spec_helper'

feature "User log out" do
  scenario "User logs out" do
    login
    click_link 'Log out'
    expect(page).to have_content('You have logged out.')
  end
end
