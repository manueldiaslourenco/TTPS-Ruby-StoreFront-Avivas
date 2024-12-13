class AddLengthValidationToUsersAndClients < ActiveRecord::Migration[8.0]
  def change
    
    change_table :users do |t|
      t.change :phone, :string, limit: 10, null: false
    end

    change_table :clients do |t|
      t.change :dni, :string, limit: 10, null: false
      t.change :phone, :string, limit: 10, null: false
    end
  end
end
