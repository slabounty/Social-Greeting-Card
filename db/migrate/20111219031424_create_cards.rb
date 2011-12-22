class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :greeting
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
