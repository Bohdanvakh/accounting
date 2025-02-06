class RenameColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :components, :wieght, :weight
  end
end
