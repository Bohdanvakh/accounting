class AddAttributesToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :phone_number, :string
    add_column :users, :phone_confirmation_token, :string
    add_column :users, :token_sent_at, :datetime
  end
end
