class User < ApplicationRecord
  before_save { self.email = email.downcase }

  validates :name, presence:true, length: {maximum:50}
  VALID_EMAIL_REGEX =  /\A[a-z]+[\w\-\.]*@([a-z]+\.)*[a-z]{2,}\z/i
  validates :email, presence:true, length: {maximum:255}, format: VALID_EMAIL_REGEX, uniqueness: {case_sensitive: false}

end
