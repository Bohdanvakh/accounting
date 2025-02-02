class RenameTable < ActiveRecord::Migration[7.1]
  def change
    rename_table 'dimentions', 'dimensions'
  end
end
