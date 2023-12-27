# test/integration/posts_flow_test.rb
require 'test_helper'

class PostsFlowTest < ActionDispatch::IntegrationTest
  test 'create a new user' do
    post user_registration_path, params: {
      user: {
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
        username: 'testuser'
      }
    }

    assert_redirected_to root_path
    follow_redirect!

    assert_equal 'Welcome! You have signed up successfully.', flash[:notice]
    assert_select 'p', 'Signed in as test@example.com'
  end
end

