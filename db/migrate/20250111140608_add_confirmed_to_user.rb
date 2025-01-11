class AddConfirmedToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :confirmed, :boolean, default: false
  end
end
