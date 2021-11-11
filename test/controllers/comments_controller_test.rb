require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :users, :comments, :contributions
  setup do
    @comment = comments(:one)
    @user = users(:dani) 
    @user.password = "5QA4F9jEc6d6GD2"
  end

  test "should get index" do
    get comments_url
    assert_response :success
  end

  test "should get new" do
    get new_comment_url
    assert_response :redirect
  end

  test "should create comment" do
    post user_session_url, params: { user: { user_name: @user.user_name, password: @user.password } }
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { text: @comment.text, contribution_id: @comment.contribution_id} }
    end

    assert_redirected_to contribution_url(@comment.contribution_id) 
  end



  test "should show comment" do
    get comment_url(@comment)
    assert_response :redirect
  end

  test "should get edit" do
    get edit_comment_url(@comment)
    assert_response :redirect
  end
end
