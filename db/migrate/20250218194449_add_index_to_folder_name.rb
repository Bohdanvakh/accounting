class AddIndexToFolderName < ActiveRecord::Migration[7.1]
  def change
    add_index :folders, :name
  end
end
