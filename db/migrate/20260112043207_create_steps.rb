class CreateSteps < ActiveRecord::Migration[8.1]
  def change
    create_table :steps do |t|
      t.boolean :enabled
      t.string :name
      t.references :cabinet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
