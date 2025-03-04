class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :role
      t.string :tenant_id

      t.timestamps
    end
  end
end
