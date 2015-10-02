class Business < ActiveRecord::Base
  belongs_to :category

  validates_presence_of :name, :address, :city, :country
end
