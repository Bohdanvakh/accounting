class AddFolderTable < ActiveRecord::Migration[7.1]
  def change
    create_table :folders do |t|

      t.timestamps
    end
  end
end

