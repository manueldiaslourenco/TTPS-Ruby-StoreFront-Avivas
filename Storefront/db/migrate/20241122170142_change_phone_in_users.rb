class ChangePhoneInUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :phone, false
  end
end
