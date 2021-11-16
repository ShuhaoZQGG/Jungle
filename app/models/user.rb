class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }
end
