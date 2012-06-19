require 'test_helper'

class PostTest < ActiveSupport::TestCase
	test "post attributes must not be empty" do
		post = Post.new
		assert post.invalid?
		assert post.errors[:title].any?
		assert post.errors[:description].any?
		assert post.errors[:name].any?
		assert post.errors[:category_id].any?
	end
	
	test "post title must not be blank" do
		post = Post.new(:name => "Nitin", :description => "this is a test", :category_id => 1)
		post.title = "four"
		assert post.invalid?
		assert_equal "is too short (minimum is 5 characters)", post.errors[:title].join(';')
		
		post.title = "eight"
		assert post.valid?
	end
end
