class Expense < ApplicationRecord
  # 'inheritance_column' is defined to allow
  # the expense's 'type' column to be stored to db.
  self.inheritance_column = "inheritance_type"

  # Validates expense's 'name', 'type' and 'status' is present.
  validates :name, presence: true
  validates :type, presence: true
  validates :status, presence: true
end
