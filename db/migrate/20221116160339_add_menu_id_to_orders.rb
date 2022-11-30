class AddMenuIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :menu_id, :integer
  end
end
