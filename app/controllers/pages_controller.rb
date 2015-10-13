class PagesController < ApplicationController
  def main
    @reviews = Review.all
    @businesses = Business.all
  end
end
