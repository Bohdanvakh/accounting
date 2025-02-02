class ChangeUsers < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :username, :string, null: false, limit: 120
    change_column :users, :phone_number, :string
  end
end

