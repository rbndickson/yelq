class Business < ActiveRecord::Base
  belongs_to :category
  has_many :reviews

  validates_presence_of :name, :address, :city, :country

  def category_name
    self.category.name if self.category
  end

  def average_rating
    if self.reviews.count == 0
      nil
    else
      Review.where(business: self).average(:rating).round(1)
    end
  end

  def main_picture
    if self.main_picture_url.nil?
      "example_avatar.png"
    else
      self.main_picture_url
    end
  end
end
