class Post < ActiveRecord::Base
  attr_accessible :description, :name, :title, :tags_attributes, :category_id, :user_id
  
  belongs_to :category
  belongs_to :user
  has_many :comments, :dependent => :destroy
  
  validates :name, :presence => true
  validates :title, :presence => true,
  									:length => {:minimum => 5}
  validates :description, :presence => true
  validates :category_id, :presence => true
end
