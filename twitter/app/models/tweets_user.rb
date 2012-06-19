class TweetsUser < ActiveRecord::Base
  attr_accessible :tweet_id, :user_id
  
  validates_presence_of :tweet_id, :user_id
  
  belongs_to :tweet
  belongs_to :user
end
