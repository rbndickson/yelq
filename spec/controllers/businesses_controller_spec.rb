require "rails_helper"

describe BusinessesController do
  describe "GET index" do
    it "assigns @businesses to all businesses" do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to match_array([business1, business2])
    end

    it "orders the businesses newest first" do
      business1 = Fabricate(:business)
      business2 = Fabricate(:business)
      get :index
      expect(assigns(:businesses)).to eq([business2, business1])
    end
  end

  describe "GET show" do
    let(:business) { Fabricate(:business) }

    it "assigns @business" do
      get :show, id: business.id
      expect(assigns(:business)).to eq(business)
    end

    it "assigns @reviews to all reviews" do
      review1 = Fabricate(:review, business_id: business.id)
      review2 = Fabricate(:review, business_id: business.id)
      get :show, id: business.id
      expect(assigns(:reviews)).to match_array([review1, review2])
    end

    it "orders the reviews newest first" do
      review1 = Fabricate(:review, business_id: business.id)
      review2 = Fabricate(:review, business_id: business.id)
      get :show, id: business.id
      expect(assigns(:reviews)).to eq([review2, review1])
    end
  end

  describe "GET new" do
    context "with authenticated user" do
      it "assigns @business" do
        user = Fabricate(:user)
        set_current_user
        get :new
        expect(assigns(:business)).to be_new_record
        expect(assigns(:business)).to be_instance_of(Business)
      end
    end

    context "with unauthenticated user" do
      it "redirects to the login page" do
        get :new
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
