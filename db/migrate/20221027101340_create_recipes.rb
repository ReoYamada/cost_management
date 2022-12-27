class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.integer :gram
      t.integer :menu_id

      t.timestamps
    end
  end
end
