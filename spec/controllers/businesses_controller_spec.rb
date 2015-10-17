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

  describe "POST create" do
    context "with authenicated user" do
      let(:user) { Fabricate(:user) }

      context "with valid inputs" do
        let(:cafe) { Category.create!(name: "Cafe") }

        before do
          set_current_user(user)
          attributes = Fabricate.attributes_for(:business)
          attributes[:category_id] = cafe.id
          post :create, business: attributes
        end

        it "saves the business to the database" do
          expect(Business.count).to eq(1)
        end

        it "redirects to the business page" do
          expect(response).to redirect_to(business_path(Business.first))
        end

        it "displays a success message" do
          expect(flash[:success]).not_to be_blank
        end

        it "creates a review associated to a category" do
          expect(Business.first.category).to eq(cafe)
        end
      end

      context "with invalid inputs" do
        before do
          set_current_user(user)
          post :create, business: { name: "Only Name" }
        end

        it "displays an error message" do
          expect(flash[:danger]).not_to be_blank
        end

        it "renders the new business page" do
          expect(flash[:danger]).not_to be_blank
        end
      end
    end

    context "with unauthenicated user" do
      before { post :create, business: Fabricate.attributes_for(:business) }

      it "does not save the review to the database" do
        expect(Business.count).to eq(0)
      end

      it "redirects to the login page" do
        expect(response).to redirect_to(login_path)
      end
      it "displays an error message" do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end

  describe "GET search" do
    let (:business) { Fabricate(:business) }

    context "with authenticated users" do
      before do
        set_current_user
        get :search, search_terms: { name: business.name, city: business.city }
      end

      it "assigns @search_term" do
        expect(assigns(:search_terms)).to eq(
        { 'name' => business.name, 'city' => business.city }) # need => here
      end

      it "assigns @results" do
        expect(assigns(:results)).to eq([business])
      end
    end
  end
end
