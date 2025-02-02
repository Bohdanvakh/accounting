class ChangeComponents < ActiveRecord::Migration[7.1]
  def change
    change_column :components, :price, :float, null: false
    add_column :components, :currency, :string, null: false
    change_column :components, :name, :string, null: false, limit: 120
  end
end
