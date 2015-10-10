class Business < ActiveRecord::Base
  belongs_to :category
  has_many :reviews

  validates_presence_of :name, :address, :city, :country
end
