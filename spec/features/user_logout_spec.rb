require 'spec_helper'

feature "User logs out" do
  scenario "" do
    login
    click_link 'Log out'
    expect(page).to have_content('You have logged out.')
  end
end
