require 'rails_helper'

describe Business do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:reviews) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:country) }

  describe "#category_name" do
    it "returns the category name when business has a category" do
      cafe = Category.create!(name: "cafe")
      business = Fabricate(:business, category: cafe)
      expect(business.category_name).to eq("cafe")
    end

    it "returns nil when there is no category" do
      business = Fabricate(:business)
      expect(business.category_name).to be_nil
    end
  end

  describe "#average_rating" do
    it "returns nil when there are no reviews" do
      business = Fabricate(:business)
      expect(business.average_rating).to eq(nil)
    end

    it "returns the average of the ratings when there are reviews" do
      business = Fabricate(:business)
      Fabricate(:review, rating: 4, business: business)
      Fabricate(:review, rating: 5, business: business)
      expect(business.average_rating).to eq(4.5)
    end
  end

  describe "#main_picture" do
    it "returns the main picture url when it is present" do
      business = Fabricate(:business, main_picture_url: "abc.png")
      expect(business.main_picture).to eq("abc.png")
    end
    it "returns the example_avatar when there is no picture url" do
      business = Fabricate(:business)
      expect(business.main_picture).to eq("example_avatar.png")
    end
  end
end
