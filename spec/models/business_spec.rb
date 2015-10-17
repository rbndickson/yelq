require 'rails_helper'

describe Business do
  it { is_expected.to belong_to(:category) }
  it { is_expected.to have_many(:reviews) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:address) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:country) }

  describe "search_by_name_and_city" do
    context "with only name entered" do
      it "returns an empty array if there are no matches" do
        Fabricate(:business, name: "ABC Mart")
        Fabricate(:business, name: "DEF Mart")
        expect(Business.search_by_name_and_city({name: "XYZ Mart", city: ""})).to eq([])
      end

      it "returns an array of one video for an exact match" do
        abcmart = Fabricate(:business, name: "ABC Mart")
        Fabricate(:business, name: "DEF Mart")
        expect(Business.search_by_name_and_city({name: "ABC Mart", city: ""})).to eq([abcmart])
      end

      it "returns an array of one video for a partial match" do
        abcmart = Fabricate(:business, name: "ABC Mart")
        Fabricate(:business, name: "DEF Mart")
        expect(Business.search_by_name_and_city({name: "ABC", city: ""})).to eq([abcmart])
      end

      it "returns an array of all matches for multiple matches" do
        abcmart = Fabricate(:business, name: "ABC Mart")
        defmart = Fabricate(:business, name: "DEF Mart")
        Fabricate(:review, business: defmart)
        Fabricate(:review)
        expect(Business.search_by_name_and_city({name: "Mart", city: ""})).to match_array([defmart, abcmart])
      end
    end

    context "with only city entered" do
      it "returns an empty array if there are no matches" do
        Fabricate(:business, name: "ABC Mart", city: "Berlin")
        defmart = Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "", city: "London"})).to eq([])
      end

      it "returns an array of one video for an exact match" do
        Fabricate(:business, name: "ABC Mart", city: "Berlin")
        defmart = Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "", city: "Paris"})).to eq([defmart])
      end

      it "returns an array of one video for a partial match" do
        Fabricate(:business, name: "ABC Mart", city: "Berlin")
        defmart = Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "", city: "Par"})).to eq([defmart])
      end

      it "returns an array of all matches for multiple matches" do
        abcmart = Fabricate(:business, name: "ABC Mart", city: "Berlin")
        defmart = Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "", city: "r"})).to eq([abcmart, defmart])
      end
    end

    context "with name and city entered" do
      it "returns an empty array if there are no matches" do
        Fabricate(:business, name: "ABC Mart", city: "Berlin")
        Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "XYZ Shop", city: "Tokyo"})).to eq([])
      end

      it "returns an empty array if there is a match of only name" do
        Fabricate(:business, name: "ABC Mart", city: "Berlin")
        Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "ABC Mart", city: "Tokyo"})).to eq([])
      end

      it "returns an empty array if there is a match of only city" do
        Fabricate(:business, name: "ABC Mart", city: "Berlin")
        Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "XYZ Shop", city: "Berlin"})).to eq([])
      end

      it "returns an array of one video for an exact match" do
        abcmart = Fabricate(:business, name: "ABC Mart", city: "Berlin")
        Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "ABC Mart", city: "Berlin"})).to eq([abcmart])
      end
      it "returns an array of one video for a partial match" do
        abcmart = Fabricate(:business, name: "ABC Mart", city: "Berlin")
        Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "ABC", city: "Berlin"})).to eq([abcmart])
      end
      it "returns an array of all matches for multiple matches" do
        abcmart = Fabricate(:business, name: "ABC Mart", city: "Berlin")
        defmart = Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "Mart", city: "r"})).to eq([abcmart, defmart])
      end
    end

    context "with both fields empty" do
      it "returns an empty array when searching for a blank string" do
        Fabricate(:business, name: "ABC Mart", city: "Berlin")
        Fabricate(:business, name: "DEF Mart", city: "Paris")
        expect(Business.search_by_name_and_city({name: "", city: ""})).to eq([])
      end
    end
  end

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
