class ReviewsController < ApplicationController

  def new
    require_user
    @review = Review.new
    @business = Business.find(params[:business_id])
  end
  
end
