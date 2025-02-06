class AddCascadeDeleteToDimentions < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :dimensions, :components
    add_foreign_key :dimensions, :components, on_delete: :cascade
  end
end
