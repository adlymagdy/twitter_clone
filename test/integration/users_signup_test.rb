require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, user: {name: "", email: "asas", password: "foo", password_confirmation: "foobar"}
    end
    assert_template "users/new"
  end
  
  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post_via_redirect users_path, user: {name: "Adly", email: "email@email.com", password: "foooooo", password_confirmation: "foooooo"}
    end
    assert_template "users/show"
  end
end
