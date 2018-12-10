class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.references :user
      t.text :title

      t.timestamps
    end
  end
end
