require 'rails_helper'

describe ReviewsController do
  describe 'GET new' do
    context 'with an authorised user' do
      let(:user) { Fabricate(:user) }
      let(:business) { Fabricate(:business) }
      before { set_current_user(user) }

      it 'assigns @review' do
        get :new, business_id: business.id
        expect(assigns(:review)).to be_new_record
        expect(assigns(:review)).to be_instance_of(Review)
      end

      it 'assigns @business' do
        get :new, business_id: business.id
        expect(assigns(:business)).to eq(business)
      end
    end

    context 'with an unauthorised user' do
      let(:business) { Fabricate(:business) }

      it 'redirects to the login path' do
        get :new, business_id: business.id
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
