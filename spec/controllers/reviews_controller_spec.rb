require 'rails_helper'

describe ReviewsController do
  describe 'GET new' do
    let(:user) { Fabricate(:user) }
    let(:business) { Fabricate(:business) }

    context 'with authenicated user' do
      before do
        set_current_user(user)
        get :new, business_id: business.id
      end

      it 'assigns @review' do
        expect(assigns(:review)).to be_new_record
        expect(assigns(:review)).to be_instance_of(Review)
      end

      it 'assigns @business' do
        get :new, business_id: business.id
        expect(assigns(:business)).to eq(business)
      end
    end

    context 'with unauthenticated user' do
      it 'redirects to the login path' do
        get :new, business_id: business.id
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe 'POST create' do
    context 'with authenicated user' do
      context 'with valid inputs' do
        let(:business) { Fabricate(:business) }
        let(:user) { Fabricate(:user) }

        before do
          set_current_user(user)
          post :create, id: user.id, business_id: business.id,
          review: { rating: 5, content: "Great!" }
        end

        it 'saves the review to the database' do
          expect(Business.count).to eq(1)
        end

        it 'redirects to the business page' do
          expect(response).to redirect_to(business_path(business))
        end

        it 'creates a review associated with the business reviewed' do
          expect(Review.first.business).to eq(business)
        end

        it 'creates a review associated with the signed in user' do
          expect(Review.first.creator).to eq(user)
        end

        it 'displays a success message' do
          expect(flash[:success]).not_to be_blank
        end
      end

      context 'with invalid inputs' do
        let(:business) { Fabricate(:business) }
        let(:user) { Fabricate(:user) }

        before do
          set_current_user(user)
          post :create, id: user.id, business_id: business.id,
          review: { rating: 5 }
        end

        it 'displays an error message' do
          expect(flash[:danger]).not_to be_blank
        end

        it 'renders the new review page' do
          expect(response).to render_template(:new)
        end

        it 'assigns @business' do
          expect(assigns(:business)).to eq(business)
        end
      end
    end

    context 'with unauthenicated user' do
      let(:business) { Fabricate(:business) }
      let(:user) { Fabricate(:user) }

      before do
        post :create, id: user.id, business_id: business.id,
        review: { rating: 5, content: "Great!" }
      end

      it 'does not save the review to the database' do
        expect(Review.count).to eq(0)
      end

      it 'redirects to the login path' do
        expect(response).to redirect_to(login_path)
      end

      it 'displays an error message' do
        expect(flash[:danger]).not_to be_blank
      end
    end
  end
end
