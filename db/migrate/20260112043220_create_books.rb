class CreateBooks < ActiveRecord::Migration[8.1]
  def change
    create_table :books do |t|
      t.boolean :enabled
      t.string :name
      t.string :isbn
      t.references :category, null: false, foreign_key: true
      t.references :step, null: false, foreign_key: true
      t.string :memo

      t.timestamps
    end
  end
end
