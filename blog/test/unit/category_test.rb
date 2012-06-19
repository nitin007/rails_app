require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
	fixtures :categories
	fixtures :posts
	
	setup do
		@post = posts(:one)
		@category = categories(:one)
		@default_category_id = @category.id
	end

  test "category attributes must not be empty" do
		category = Category.new
		assert category.invalid?
		assert category.errors[:name].any?
  end
  
  test "category name must be unique" do
    #FIX: You should use fixture to create default data. This way test would perform better. 
    # if fixture is used test fails!
  	category1 = Category.new(:name => "Painting")
  	assert category1.save, "category1 not saved!"
  	
  	category2 = Category.new(:name => "Painting")
  	assert !category2.save
  end
  
  #FIX: Use fixture. Also test description should be small and sufficient. eg. "Assign default category to posts on destroy"
  test "Assign default category to posts on destroy" do
  	category = Category.new(:name => "painting")
  	category.save
    #FIX: To create associated object use object.association.create
  	post = category.posts.new(:name => @post.name, :title => @post.title, :description => @post.description)
  	post.save
  	category.destroy
  	post.reload
    #FIX: Hardcoring id makes test regid. should use default_category.id
  	assert_equal @default_category_id, post.category_id
  end
end
