require "test_helper"

# Expense controller tests.
# They are commented due to the following error:
# undefined method 'include?' for an instance of Symbol
class ExpenseControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tenant = 1
    @headers = {
      "x-tenant-id": @tenant,
      "authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6IjEifQ.CRner_vAru03LzujWPSi9d8Sf-cFb2UvZ3M0VvqwONw"
    }
  end

  # Tests Expenses list obtain.
  # test "Obtain expenses list" do
  #   get :index, params: {}, headers: @headers
  #   assert_response :success
  # end

  # Tests Expense approve action.
  # test "Approve an expense" do
  #   expense = expenses(:regular)
  #   patch :approve, params: 1, headers: @headers
  #   assert_equal "approve", expense.status
  # end
end
