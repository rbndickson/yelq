require 'rails_helper'

describe SessionsController do
  describe "GET new" do
    context "with authenticated user" do
      it "redirects to the home path" do
        set_current_user
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    context "with unauthenticated user" do
      it "renders the new user template" do
        get :new
        expect(response).to render_template(:new)
      end
    end
  end

  describe "POST create" do
    let (:alice) { Fabricate(:user) }

    context "with valid email and password" do
      before { post :create, email: alice.email, password: alice.password }

      it "saves the users id to the session" do
        expect(session[:user_id]).to eq(alice.id)
      end

      it "redirects to the home path" do
        expect(response).to redirect_to(root_path)
      end

      it "sets the flash notice" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid email or password" do
      before do
        post :create, email: alice.email, password: alice.password + 'aaa'
      end

      it "does not put the user in the session" do
        expect(session[:user_id]).to be_nil
      end

      it "redirects to the login path" do
        expect(response).to redirect_to(login_path)
      end

      it "displays an error message" do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "GET destroy" do
    before do
      set_current_user
      get :destroy
    end

    it "clears the session for the user" do
      expect(session[:user_id]).to be_nil
    end

    it "redirects to the root path" do
      expect(response).to redirect_to(root_path)
    end

    it "displays a confirmation message" do
      expect(flash[:info]).to be_present
    end
  end
end
