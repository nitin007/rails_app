require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
	fixtures :comments
	fixtures :posts
  setup do
		@comment = comments(:one)
  end
  
  test "should create comment" do
    assert_difference('Comment.count') do
      post :create, comment: { commenter: @comment.commenter, body: @comment.body }, :post_id => 1
    end

    assert_redirected_to post_path(assigns(:post))
  end
  
  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete :destroy, id: @comment, :post_id => 1
    end

    assert_redirected_to post_path(assigns(:post))
  end
end
