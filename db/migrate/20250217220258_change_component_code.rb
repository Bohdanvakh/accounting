class ChangeComponentCode < ActiveRecord::Migration[7.1]
  def change
    change_column :components, :code, :string
  end
end
