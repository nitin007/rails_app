class Tweet < ActiveRecord::Base
  attr_accessible :message, :ttype
  
  has_many :tweets_users
  has_many :users, :through => :tweets_users
end
