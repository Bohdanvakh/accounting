class AddAssociationsBetweenComponentAndFolder < ActiveRecord::Migration[7.1]
  def change
    add_reference :components, :folder, foreign_key: true, null: false
  end
end
