class AddActiveParamToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :active, :boolean, default: false
  end
end
