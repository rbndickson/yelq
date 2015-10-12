class BusinessesController < ApplicationController
  before_action :require_user, only: [:new]

  def index
    @businesses = Business.order("id DESC").all
  end

  def new
    @business = Business.new
  end

  def show
    @business = Business.find(params[:id])
    @reviews = @business.reviews.order("id DESC")
  end
end
