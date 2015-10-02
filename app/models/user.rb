class User < ActiveRecord::Base
  has_secure_password validations: false

  validates_presence_of :first_name, :last_name, :email, :password_digest
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 8, on: :create
end
