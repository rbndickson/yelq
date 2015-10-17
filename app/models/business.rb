class Business < ActiveRecord::Base
  belongs_to :category
  has_many :reviews

  validates_presence_of :name, :address, :city, :country

  def self.search_by_name_and_city(search_terms)
    if search_terms[:name].present? && search_terms[:city].present?
      where('name ILIKE ? AND city ILIKE ?',
      "%#{search_terms[:name]}%", "%#{search_terms[:city]}%")
    elsif search_terms[:name].present?
      where('name ILIKE ?', "%#{search_terms[:name]}%")
    elsif search_terms[:city].present?
      where('city ILIKE ?', "%#{search_terms[:city]}%")
    else
      return []
    end
  end

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
