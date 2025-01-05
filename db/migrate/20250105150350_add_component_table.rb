class AddComponentTable < ActiveRecord::Migration[7.1]
  def change
    create_table :components do |t|

      t.timestamps
    end
  end
end

