class CreateSignatures < ActiveRecord::Migration
  def change
    create_table :signatures do |t|
      t.integer :signer_id
      t.integer :card_id
      t.boolean :signed,    :default => false
      t.text :message

      t.timestamps
    end
  end
end
