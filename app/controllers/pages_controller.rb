class PagesController < ApplicationController
  def main
    @reviews = Review.all.reverse[0..5]
    @businesses = Business.joins(:reviews)
      .group("businesses.id")
      .order("count(reviews.id) DESC")
      .limit(6)
  end
end
