class CreateFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :foods do |t|
      t.string :name
      t.integer :unit_price_per_kilo

      t.timestamps
    end
  end
end
