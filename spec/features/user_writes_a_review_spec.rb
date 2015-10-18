require 'spec_helper'

feature "User adds review to business" do
  scenario "with authenticated user and valid inputs" do
    business = Fabricate(:business)
    login
    click_link 'Business Index'
    click_link business.name
    click_link 'Write a Review'
    select('3 stars', from: 'Rating')
    fill_in('Content', with: 'Pretty Good!')
    click_button('Post Review')
    expect(page).to have_content('Pretty Good!')
  end

  scenario "with authenticated user but invalid inputs" do
    business = Fabricate(:business)
    login
    click_link 'Business Index'
    click_link business.name
    click_link 'Write a Review'
    select('3 stars', from: 'Rating')
    click_button('Post Review')
    expect(page).to have_content('Please complete both the rating and comment')
  end

  scenario "with unuathenticated user" do
    business = Fabricate(:business)
    visit root_path
    click_link 'Business Index'
    click_link business.name
    click_link 'Write a Review'
    expect(page).to have_content('Sorry you must be logged in to do that')
  end
end
