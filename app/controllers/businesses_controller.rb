class BusinessesController < ApplicationController

  def index
    @businesses = Business.order("id DESC").all
  end

end
