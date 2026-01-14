class CreateCabinets < ActiveRecord::Migration[8.1]
  def change
    create_table :cabinets do |t|
      t.boolean :enabled
      t.string :name
      t.references :floor, null: false, foreign_key: true

      t.timestamps
    end
  end
end
