class AddAssociationsBetweenFolderAndUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :folders, :user, foreign_key: true, null: false
  end
end
