class AddDetailsToComponents < ActiveRecord::Migration[7.1]
  def change
    change_table :components do |t|
      t.decimal :wieght, precision: 10, scale: 2, null: false
      t.string :measurement, null: false
    end
  end
end
