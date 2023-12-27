# test/controllers/posts_controller_test.rb
require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get new" do
    get new_post_path
    assert_response :success
    assert_select 'h2', 'New Post'
  end
end
