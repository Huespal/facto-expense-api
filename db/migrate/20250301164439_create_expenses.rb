class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.string :type
      t.string :status
      t.string :hotel_name
      t.datetime :check_in_date
      t.datetime :check_out_date
      t.string :transportation_mode
      t.string :route
      t.decimal :mileage
      t.decimal :amount

      t.timestamps
    end
  end
end
