# TODO: WA: This model does not have any tests.
class Tweet < ActiveRecord::Base
	include UsersHelper
  attr_accessible :message, :ttype, :user_id
  
  has_many :tweets_users, :dependent => :destroy
  has_many :users, :through => :tweets_users
  belongs_to :user
  
  validates :message, :length => {:maximum => 160}
  # Fixed :NG I was also managing this with javascript. Do we really need to manage here?
  # WA: Yes we do. Consider a situation where you are exposing your application
  # to outer world as a web service. You may or may not be able to control the
  # clients that make request to your application. In that case this validation
  # will make sure that our database is consistent. Moreover, if you try to create
  # a tweet from console, this will make sure you do not put incosistent data in
  # your db. Please remove this comment after reading.
  
 	def find_if_retweeted(uid)
		TweetsUser.find(:first, :conditions => ['user_id = ? and tweet_id = ?', uid, self.id])
	end
end
