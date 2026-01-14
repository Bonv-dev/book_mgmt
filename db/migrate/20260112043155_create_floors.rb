class CreateFloors < ActiveRecord::Migration[8.1]
  def change
    create_table :floors do |t|
      t.boolean :enabled
      t.string :name

      t.timestamps
    end
  end
end
