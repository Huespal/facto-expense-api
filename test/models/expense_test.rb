require "test_helper"

# Expense model tests.
class ExpenseTest < ActiveSupport::TestCase
  test "should not save expense without 'name', 'type' and 'status'" do
    expense = Expense.new
    assert_not expense.save, "Saved the article without name, type and status"
  end
  test "should save expense with 'name', 'type' and 'status'" do
    expense = Expense.new(name: "test", type: "regular", status: "pending")
    assert expense.save, "Saved the article with name, type and status"
  end
end
