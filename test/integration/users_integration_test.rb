require 'test_helper'

class UsersIntegrationTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
  end

  test "can update username and email in settings" do
    get user_settings_path
    assert_response :success

    patch user_path(@user), params: { user: { username: "new_username", digest_frequency: "weekly" } }
    assert_redirected_to user_settings_path
    assert_equal "Имя пользователя успешно изменено.", flash[:notice]

    @user.reload
    assert_equal "new_username", @user.username
    assert_equal "weekly", @user.digest_frequency

    get user_settings_path
    assert_response :success

    patch update_email_user_path(@user), params: { user: { email: "new_email@example.com" } }
    assert_redirected_to user_settings_path
    assert_equal "Email успешно обновлен.", flash[:notice]

    @user.reload
    assert_equal "new_email@example.com", @user.email
  end
end
