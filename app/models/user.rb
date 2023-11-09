class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  validates :name,  presence:  {message: "Name can't be blank" }, length: { maximum: 50 }
  validates :username,  presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }


  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end