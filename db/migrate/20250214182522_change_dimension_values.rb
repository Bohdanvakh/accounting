class ChangeDimensionValues < ActiveRecord::Migration[7.1]
  def change
    change_column :dimensions, :length, :integer
    change_column :dimensions, :width, :integer
    change_column :dimensions, :height, :integer
  end
end
