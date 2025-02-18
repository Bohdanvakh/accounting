class AddCodeToFolders < ActiveRecord::Migration[7.1]
  def change
    add_column :folders, :code, :string
  end
end
