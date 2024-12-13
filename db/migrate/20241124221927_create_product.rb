class CreateProduct < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|

      t.string :name, null: false
      t.text :description, null: false, default: ""
      t.decimal :price, null: false
      t.integer :stock, null: false, default: 0
      t.string :category, null: false, default: ""
      t.string :size
      t.string :color
      
      t.datetime :deleted_at

      t.timestamps

    end
  end
end
