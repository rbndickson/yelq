class ReviewsController < ApplicationController
  before_action :require_user

  def new
    @review = Review.new
    @business = Business.find(params[:business_id])
  end

  def create
    @business = Business.find(params[:business_id])
    @review = @business.reviews.build(
      user: current_user,
      rating: params[:review][:rating],
      content: params[:review][:content]
    )
    if @review.save
      redirect_to @review.business
      flash[:success] = "Thank you for your review!"
    else
      flash[:danger] = "Please complete both the rating and comment."
      render :new
    end
  end

end
