class CreateDimentions < ActiveRecord::Migration[7.1]
  def change
    create_table :dimentions do |t|
      t.float :length, null: false
      t.float :width, null: false
      t.float :height, null: false
      t.references :component, null: false, foreign_key: true
      t.timestamps
    end
  end
end
