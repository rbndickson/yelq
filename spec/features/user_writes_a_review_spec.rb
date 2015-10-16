require 'spec_helper'

feature "User adds review to business" do
  scenario "with valid inputs" do
    business = Fabricate(:business)
    login
    click_link business.name
    click_link 'Write a Review'
    select('3 stars', from: 'Rating')
    fill_in('Content', with: 'Pretty Good!')
    click_button('Post Review')
    expect(page).to have_content('Pretty Good!')
  end
end
