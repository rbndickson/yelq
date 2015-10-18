require "rails_helper"

describe PagesController do
  describe "GET main" do
    let(:user) { Fabricate(:user) }
    let(:business1) { Fabricate(:business) }
    let(:business2) { Fabricate(:business) }
    let(:business3) { Fabricate(:business) }

    it "assigns @reviews" do
      review1 = Fabricate(:review, creator: user, business: business1)
      review2 = Fabricate(:review, creator: user, business: business2)
      get :main
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "orders @reviews newest first" do
      review = Fabricate(:review, creator: user, business: business1)
      new_review = Fabricate(:review, creator: user, business: business2)
      get :main
      expect(assigns(:reviews)).to eq([new_review, review])
    end

    it "limits the number of reviews to 6" do
      10.times { Fabricate(:review, creator: user, business: business1) }
      get :main
      expect(assigns(:reviews).count).to eq(6)
    end

    it "assigns @businesses" do
      Fabricate(:review, creator: user, business: business1)
      Fabricate(:review, creator: user, business: business2)
      get :main
      expect(assigns(:businesses)).to match_array([business1, business2])
    end

    it "orders @businesses by number of reviews" do
      Fabricate(:review, creator: user, business: business1)
      10.times { Fabricate(:review, creator: user, business: business2) }
      5.times { Fabricate(:review, creator: user, business: business3) }
      get :main
      expect(assigns(:businesses)).to eq([business2, business3, business1])
    end

    it "limits the number of businesses to 6" do
      10.times do
        business = Fabricate(:business)
        Fabricate(:review, creator: user, business: business)
      end
      get :main
      expect(assigns(:businesses).count.count).to eq(6)
    end
  end
end
