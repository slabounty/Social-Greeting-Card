class AddImageFileNameToCards < ActiveRecord::Migration
  def change
    add_column :cards, :image_file_name, :string
  end
end
