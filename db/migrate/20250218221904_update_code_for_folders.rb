class UpdateCodeForFolders < ActiveRecord::Migration[7.1]
  def change
    change_column :folders, :code, :string, null: false
  end
end
