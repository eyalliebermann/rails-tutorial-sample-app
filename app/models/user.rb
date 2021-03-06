class User < ApplicationRecord
  before_save { email.downcase! }

  validates :name, presence:true, length: {maximum:50}
  VALID_EMAIL_REGEX =  /\A[a-z]+[\w\-\.]*@([a-z]+\.)*[a-z]{2,}\z/i
  validates :email, presence:true, length: {maximum:255}, format: VALID_EMAIL_REGEX, uniqueness: {case_sensitive: false}
  validates :password, presence:true, length: {minimum:6}
  has_secure_password

  #we need the digest method for the testing fixture
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
               BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
