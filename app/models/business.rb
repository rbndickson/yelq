class Business < ActiveRecord::Base
  belongs_to :category
  has_many :reviews

  validates_presence_of :name, :address, :city, :country

  def average_rating
    if self.reviews.count == 0
      nil
    else
      Review.where(business: self).average(:rating).round(1)
    end
  end
end
