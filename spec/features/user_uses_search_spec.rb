require 'spec_helper'

feature "User uses search" do
  let(:business1) { Fabricate(:business) }
  let(:business2) { Fabricate(:business) }
  let(:user) { Fabricate(:user) }

  scenario "with unauthenticated user" do
    Fabricate(:review, business: business1, creator: user)
    Fabricate(:review, business: business2, creator: user)
    visit root_path
    search_for_name(business1)
    expect(page).to have_content(business1.name)
    click_link(business1.name)
    expect(page).to have_content(business1.reviews.first.content)

    search_for_city(business2)
    expect(page).to have_content(business2.name)
    click_link(business2.name)
    expect(page).to have_content(business2.reviews.first.content)
  end

  scenario "with authenticated user" do
    Fabricate(:review, business: business1, creator: user)
    Fabricate(:review, business: business2, creator: user)
    login
    search_for_name(business1)
    expect(page).to have_content(business1.name)
    click_link(business1.name)
    expect(page).to have_content(business1.reviews.first.content)

    search_for_city(business2)
    expect(page).to have_content(business2.name)
    click_link(business2.name)
    expect(page).to have_content(business2.reviews.first.content)
  end
end

def search_for_name(business)
  fill_in('name', with: business.name)
  click_button('search_button')
end

def search_for_city(business)
  fill_in('city', with: business.city)
  click_button('search_button')
end
