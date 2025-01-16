class AddParamsToFolder < ActiveRecord::Migration[7.1]
  def change
    add_column :folders, :name, :string
  end
end
