class AddImgPathToPersonas < ActiveRecord::Migration[6.0]
  def change
    add_column :personas, :img_path, :string, after: :initial_level
  end
end
