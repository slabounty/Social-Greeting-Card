class AddHashValueToCards < ActiveRecord::Migration
  def change
    add_column :cards, :hash_value, :string
  end
end
