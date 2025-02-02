class ChangeFolders < ActiveRecord::Migration[7.1]
  def change
    change_column :folders, :name, :string, null: false, limit: 120
    change_column :folders, :description, :string, limit: 120
  end
end
