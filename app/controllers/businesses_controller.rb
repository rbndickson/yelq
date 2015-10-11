class BusinessesController < ApplicationController

  def index
    @businesses = Business.order("id DESC").all
  end

  def show
    @business = Business.find(params[:id])
    @reviews = @business.reviews.order("id DESC")
  end
end
