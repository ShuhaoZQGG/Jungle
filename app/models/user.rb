class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: true }
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    @users = User.all
    @users.each do |user| 
      if user.email.downcase == email.strip.downcase && user.authenticate(password)
        return user
      end
    end
   return false
  end
end
