class AddDescriptionToFolder < ActiveRecord::Migration[7.1]
  def change
    add_column :folders, :description, :string, limit: 120
  end
end
