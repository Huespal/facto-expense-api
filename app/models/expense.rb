class Expense < ApplicationRecord
  # 'inheritance_column' is defined to allow
  # the expense's 'type' column to be stored to db.
  self.inheritance_column = "inheritance_type"

  # Custom method to filter expenses by status.
  def self.by_status(status)
    if status
      where(status: status)
    else
      all
    end
  end

  # Custom method to filter expenses by date range.
  def self.by_date_range(from, to)
    if from && to
      where(created_at: from..to)
    elsif from
      where(created_at: from..)
    elsif to
      where(created_at: ..to)
    else
      all
    end
  end

  # Validates expense's 'name', 'type' and 'status' is present.
  validates :name, presence: true
  validates :type, presence: true
  validates :status, presence: true
end
