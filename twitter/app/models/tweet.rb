class Tweet < ActiveRecord::Base
  attr_accessible :message, :ttype, :user_id
  
  # TODO: WA: You are missing a belongs_to association to User model.
  has_many :tweets_users
  has_many :users, :through => :tweets_users
  # FIXME: WA: You do not have any validation on message length.
  # This will let users creae tweets more than specified number
  # of characters.
end
