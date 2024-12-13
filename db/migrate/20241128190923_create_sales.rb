class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.references :client, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :sale_date, null: false
      t.decimal :total_amount, precision: 10, scale: 2, null: false, default: 0.0

      t.timestamps
    end
  end
end
