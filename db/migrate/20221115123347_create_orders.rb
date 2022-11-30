class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :output
      t.date :year_and_month

      t.timestamps
    end
  end
end
