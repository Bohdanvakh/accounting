class AddValueToComponent < ActiveRecord::Migration[7.1]
  def change
    add_column :components, :price, :integer
    add_column :components, :code, :integer
    add_column :components, :name, :string
  end
end
