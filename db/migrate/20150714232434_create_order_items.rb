class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.references :order_id, index: true, foreign_key: true
      t.references :product_id, index: true, foreign_key: true
      t.references :user_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
