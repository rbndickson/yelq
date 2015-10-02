class BusinessesController < ApplicationController

  def index
    @businesses = Business.order("id DESC").all
  end

  def show
    @business = Business.find(params[:id])
  end
end
