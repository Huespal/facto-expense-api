require "test_helper"

# User model tests.
class UserTest < ActiveSupport::TestCase
  test "should not save user without unique 'username'" do
    user1 = User.new(username: "test")
    user1.save
    user2 = User.new(username: "test")
    assert_not user2.save, "Saved the user without unique username"
  end
end
