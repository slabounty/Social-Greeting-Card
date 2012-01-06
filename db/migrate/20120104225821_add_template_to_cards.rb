class AddTemplateToCards < ActiveRecord::Migration
  def change
    add_column :cards, :template_id, :integer
    remove_column :cards, :image_name
  end
end
