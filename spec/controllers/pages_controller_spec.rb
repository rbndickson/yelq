require "rails_helper"

describe PagesController do
  describe "GET main" do
    let(:user) { Fabricate(:user) }
    let(:business1) { Fabricate(:business) }
    let(:business2) { Fabricate(:business) }

    it "assigns @reviews" do
      review1 = Fabricate(:review, creator: user, business: business1)
      review2 = Fabricate(:review, creator: user, business: business2)
      get :main
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "assigns @businesses" do
      Fabricate(:review, creator: user, business: business1)
      Fabricate(:review, creator: user, business: business2)
      get :main
      expect(assigns(:businesses)).to match_array([business1, business2])
    end
  end
end
