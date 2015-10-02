require 'rails_helper'

describe BusinessesController do
  describe 'GET index' do
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
end
