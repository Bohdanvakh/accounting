class AddUniqueIndexToDimensions < ActiveRecord::Migration[7.1]
  def change
    remove_index :dimensions, :component_id
    add_index :dimensions, :component_id, unique: true
  end
end
