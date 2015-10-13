class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :reviews

  validates_presence_of :first_name, :last_name, :email, :password_digest
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 8

  def last_name_intital
    last_name[0]
  end

  def display_name
    first_name + " " + last_name_intital
  end
end
