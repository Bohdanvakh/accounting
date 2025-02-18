class AddIndexForFoldersCode < ActiveRecord::Migration[7.1]
  def change
    add_index :folders, :code
  end
end
