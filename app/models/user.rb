class User < ActiveRecord::Base
  has_and_belongs_to_many :seller
  has_many :purchases
  has_many :carts, through: :purchases
  has_one :buyer
  attr_accessor :remember_token, :activation_token, :reset_token

  before_save { self.email = email.downcase }
  before_create :create_activation_digest
  before_save { self.username = username.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, length: { maximum: 30 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_one_attached :avatar

  # trying to add avatar
  # has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  # validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates_confirmation_of :password

  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  # Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def sellers_purchased_from
    Seller.all
    # Seller.joins(items: { carts: { purchase: :user } }).where(items: { carts: { purchase: { users: { email: } } } })
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil? # if remember_digest is nil, then return false

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def authenticated_activation?(activation_token)
    return false if activation_digest.nil? # if remember_digest is nil, then return false

    BCrypt::Password.new(activation_digest).is_password?(activation_token)
  end

  def authenticated_reset?(reset_token)
    return false if reset_digest.nil? # if remember_digest is nil, then return false

    BCrypt::Password.new(reset_digest).is_password?(reset_token)
  end

  # Forgets a user
  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[email name username]
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  # Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
