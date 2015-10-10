require 'rails_helper'

describe UsersController do

  describe "GET new" do
    it "assigns @user" do
      get :new
      expect(assigns(:user)).to be_new_record
      expect(assigns(:user)).to be_instance_of(User)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before { post :create, user: Fabricate.attributes_for(:user) }

      it "creates a new user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the login path" do
        expect(response).to redirect_to(login_path)
      end
    end

    context "with invalid inputs" do
      before { post :create, user: { password: "password" } }

      it "does not create a new user" do
        expect(User.count).to eq(0)
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "assigns @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end
  end

  describe "GET edit" do
    let(:alice) { Fabricate(:user) }
    before { set_current_user(alice) }

    it "assigns the user" do
      get :edit, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end

    it "shows an error message if the user does not match the current user" do
      bob = Fabricate(:user)
      get :edit, id: bob.id
      expect(flash[:error]).not_to be_blank
    end
  end

  describe "PUT update" do
    let(:alice) { Fabricate(:user, first_name: "Alice") }

    context "with valid inputs" do
      before { set_current_user(alice) }

      it "updates the user record" do
        put :update, id: alice.id, user: Fabricate.attributes_for(:user, first_name: "Newname")
        expect(alice.reload.first_name).to eq("Newname")
      end

      it "shows a message confirming the update was successful" do
        put :update, id: alice.id, user: Fabricate.attributes_for(:user)
        expect(flash[:success]).not_to be_blank
      end

      it "redirects to the user profile page" do
        put :update, id: alice.id, user: Fabricate.attributes_for(:user)
        expect(response).to redirect_to(user_path)
      end
     end

    context "with invalid inputs" do
      it "does not update the user's record" do
        set_current_user(alice)
        put :update, id: alice.id, user: Fabricate.attributes_for(:user, first_name: nil)
        expect(alice.reload.first_name).to eq("Alice")
      end

      it "renders the edit page" do
        set_current_user(alice)
        put :update, id: alice.id, user: Fabricate.attributes_for(:user, password: nil)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'GET show' do
    it 'assigns @user' do
      user = Fabricate(:user)
      get :show, id: user.id
      expect(assigns(:user)).to eq(user)
    end
  end
end
