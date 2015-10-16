require 'spec_helper'

feature 'User login' do
  scenario "with existing account" do
    alice = Fabricate(:user, first_name: "Alice")
    login(alice)

    expect(page).to have_content("Alice")
  end
end
