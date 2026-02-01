class AddModelValidates < ActiveRecord::Migration[8.1]
  def change
    add_index :cabinets, [ :floor_id, :name ], unique: true
    add_index :steps, [ :cabinet_id, :name ], unique: true
  end
end
