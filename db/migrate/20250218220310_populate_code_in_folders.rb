class PopulateCodeInFolders < ActiveRecord::Migration[7.1]
  def up
    Folder.reset_column_information
    Folder.find_each do |folder|
      folder.update!(code: generate_folder_code(folder))
    end
  end

  def down
    Folder.update_all(code: nil)
  end

  private

  def generate_folder_code(folder)
    "F_#{folder.created_at.to_i}_U#{folder.user_id}"
  end
end
