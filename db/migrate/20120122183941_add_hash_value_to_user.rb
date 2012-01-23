class AddHashValueToUser < ActiveRecord::Migration
  def change
    add_column :users, :hash_value, :string
  end
end
