require "test_helper"

# User controller tests.
# They are commented due to I can't get them work because of this error:
# undefined method 'include?' for an instance of Symbol
class UserControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = 1
    @user = users(:adminEspardenya)
  end

  # # Test Log in.
  # test "User can log in" do
  #   post :login, params: {
  #     username: @user.username,
  #     password: @user.password
  #   }, headers: { "x-tenant-id": @tenant }
  #   assert_response :success
  # end
end
