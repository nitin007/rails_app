class Category < ActiveRecord::Base
  attr_accessible :name
  
  has_many :posts
  
  before_destroy :assign_default_category
  
  validates :name, :presence => true, :uniqueness => true
  
  private
    
  def default_category
    @default_category ||= Category.find(1)
  end
  
  def assign_default_category
    default_category.posts << self.posts
  end
end
