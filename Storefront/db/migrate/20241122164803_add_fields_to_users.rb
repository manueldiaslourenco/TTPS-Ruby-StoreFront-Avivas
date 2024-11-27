class AddFieldsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :username, :string, null: false
    add_column :users, :phone, :string

    add_index :users, :username, unique: true
  end
end

