require 'spec_helper'

feature "User browses business and user profile" do
  let(:business) { Fabricate(:business) }
  let(:user) { Fabricate(:user) }

  scenario "with unauthenticated user" do
    Fabricate(:review, business: business, creator: user)
    visit root_path
    click_link(user.display_name)
    expect(page).to have_content('Yelqing Since')
    click_link(user.reviews.first.business.name)
    expect(page).to have_content(business.reviews.first.content)
  end

  scenario "with authenticated user" do
    Fabricate(:review, business: business, creator: user)
    login
    click_link(user.display_name)
    expect(page).to have_content('Yelqing Since')
    click_link(user.reviews.first.business.name)
    expect(page).to have_content(business.reviews.first.content)
  end
end
