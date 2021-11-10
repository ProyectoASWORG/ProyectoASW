require "test_helper"

class ContributionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  fixtures :users, :comments, :contributions
  setup do
    @comment = comments(:one)
    @contribution = contributions(:one)
    @user = users(:dani) 
    @user.password = "5QA4F9jEc6d6GD2"
  end

  test "like contribution" do
    post user_session_url, params: { user: { user_name: @user.user_name, password: @user.password } }
    assert_difference "Contribution.find(@contribution.id).points", 1 do
      put like_contribution_path(@contribution)
    end

    assert_response :success
  end

  test "dislike contribution" do
    
    post user_session_url, params: { user: { user_name: @user.user_name, password: @user.password } }
    assert_difference "Contribution.find(@contribution.id).points", -1 do
      put dislike_contribution_path(@contribution)
    end
    assert_response :success
  end
end
