require "rails_helper"

describe PagesController do
  describe "GET main" do
    let(:user1) { Fabricate(:user) }
    let(:business1) { Fabricate(:business) }
    let(:user2) { Fabricate(:user) }
    let(:business2) { Fabricate(:business) }

    it "assigns reviews" do
      review1 = Fabricate(:review, creator: user1, business: business1)
      review2 = Fabricate(:review, creator: user2, business: business2)
      get :main

      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "assigns businesses" do
      review1 = Fabricate(:review, creator: user1, business_id: business1.id)
      review2 = Fabricate(:review, creator: user2, business_id: business2.id)
      get :main
      expect(assigns(:businesses)).to match_array([business1, business2])
    end
  end
end
