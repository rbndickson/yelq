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
      let(:amart) { Fabricate(:business, name: "A Mart", city: "Athens") }
      let(:bmart) { Fabricate(:business, name: "B Mart", city: "Berlin") }

      it "returns an empty array if there are no matches" do
        Fabricate(:business, name: "A Mart")
        expect(Business.search_by_name_and_city({name: "C Mart", city: ""})).to eq([])
      end

      it "returns an array of one video for an exact match" do
        expect(Business.search_by_name_and_city({name: "A Mart", city: ""})).to eq([amart])
      end

      it "returns an array of one video for a partial match" do
        expect(Business.search_by_name_and_city({name: "A M", city: ""})).to eq([amart])
      end

      it "returns an array of all matches for multiple matches" do
        expect(Business.search_by_name_and_city({name: "Mart", city: ""})).to match_array([amart, bmart])
      end
    end

    context "with only city entered" do
      let(:amart) { Fabricate(:business, name: "A Mart", city: "Athens") }
      let(:bmart) { Fabricate(:business, name: "B Mart", city: "Berlin") }

      it "returns an empty array if there are no matches" do
        Fabricate(:business, name: "A Mart", city: "Athens")
        expect(Business.search_by_name_and_city({name: "", city: "London"})).to eq([])
      end

      it "returns an array of one video for an exact match" do
        expect(Business.search_by_name_and_city({name: "", city: "Athens"})).to eq([amart])
      end

      it "returns an array of one video for a partial match" do
        expect(Business.search_by_name_and_city({name: "", city: "Athens"})).to eq([amart])
      end

      it "returns an array of all matches for multiple matches" do
        expect(Business.search_by_name_and_city({name: "", city: "n"})).to eq([amart, bmart])
      end
    end

    context "with name and city entered" do
      let(:amart) { Fabricate(:business, name: "A Mart", city: "Athens") }
      let(:bmart) { Fabricate(:business, name: "B Mart", city: "Berlin") }

      it "returns an empty array if there are no matches" do
        Fabricate(:business, name: "A Mart", city: "Athens")
        expect(Business.search_by_name_and_city({name: "XYZ Shop", city: "Tokyo"})).to eq([])
      end

      it "returns an empty array if there is a match of only name" do
        Fabricate(:business, name: "A Mart", city: "Athens")
        expect(Business.search_by_name_and_city({name: "ABC Mart", city: "Tokyo"})).to eq([])
      end

      it "returns an empty array if there is a match of only city" do
        Fabricate(:business, name: "A Mart", city: "Athens")
        expect(Business.search_by_name_and_city({name: "XYZ Shop", city: "Athens"})).to eq([])
      end

      it "returns an array of one video for an exact match" do
        expect(Business.search_by_name_and_city({name: "A Mart", city: "Athens"})).to eq([amart])
      end
      it "returns an array of one video for a partial match" do
        expect(Business.search_by_name_and_city({name: "A Ma", city: "Ath"})).to eq([amart])
      end
      it "returns an array of all matches for multiple matches" do
        expect(Business.search_by_name_and_city({name: "Mart", city: "n"})).to eq([amart, bmart])
      end
    end

    context "with both fields empty" do
      it "returns an empty array when searching for a blank string" do
        Fabricate(:business, name: "A Mart", city: "Athens")
        Fabricate(:business, name: "B Mart", city: "Berlin")
        expect(Business.search_by_name_and_city({name: "", city: ""})).to eq([])
      end
    end
  end

  describe "#category_name" do
    it "returns the category name when the business has a category" do
      cafe = Category.create!(name: "Cafe")
      business = Fabricate(:business, category: cafe)
      expect(business.category_name).to eq("Cafe")
    end

    it "returns nil when the business has no category" do
      business = Fabricate(:business)
      expect(business.category_name).to be_nil
    end
  end

  describe "#average_rating" do
    it "returns the average of the ratings when there are reviews" do
      business = Fabricate(:business)
      Fabricate(:review, rating: 4, business: business)
      Fabricate(:review, rating: 5, business: business)
      expect(business.average_rating).to eq(4.5)
    end

    it "returns nil when there are no reviews" do
      business = Fabricate(:business)
      expect(business.average_rating).to eq(nil)
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
