class User < ApplicationRecord 
  
  validates :username, :email, :session_token, presence:true, uniqueness:true
  validates :password_digest, presence:true 
  validates :password, length: {minimum:6, allow_nil:true }
  
  attr_reader :password
end 