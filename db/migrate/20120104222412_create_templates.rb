class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.text :image_name

      t.timestamps
    end

    create_table :tags_templates, :id => false do |t|
        t.references :template, :tag
    end

  end
end
