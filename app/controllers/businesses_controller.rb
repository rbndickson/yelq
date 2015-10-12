class BusinessesController < ApplicationController
  before_action :require_user, only: [:new, :create]

  def index
    @businesses = Business.order("id DESC").all
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      redirect_to business_path(@business)
      flash[:success] = "Thank you, the business has been added!"
    else
      flash[:danger] = "Please complete required fields"
      render :new
    end
  end

  def show
    @business = Business.find(params[:id])
    @reviews = @business.reviews.order("id DESC")
  end

  def business_params
    params.require(:business).permit(:name, :category_id, :address, :city, :country, :phone_number, :web_address)
  end
end
