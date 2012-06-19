require 'digest/sha2'

class User < ActiveRecord::Base
  attr_accessible :password, :username, :password_confirmation
  
  before_create :hash_password
  
  validates :username, :presence => true, :uniqueness => true
  validates :password, :presence => true, 
  										 :length => {:minimum => 5}, 
  										 :confirmation => true
	  										 
  has_many :posts, :dependent => :destroy
  
  def self.authenticate(username, password)
  	User.find(:first, :conditions => ["username = ? and password = ?", username, Digest::SHA512.hexdigest(password)]) 
  end
  
  def hash_password
  	self.password = Digest::SHA512.hexdigest(self.password)
  end
end
