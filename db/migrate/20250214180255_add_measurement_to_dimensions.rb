class AddMeasurementToDimensions < ActiveRecord::Migration[7.1]
  def change
    add_column :dimensions, :measurement, :string
  end
end
