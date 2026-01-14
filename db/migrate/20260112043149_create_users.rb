class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.boolean :enabled
      t.string :name
      t.boolean :is_admin
      t.boolean :is_librarian

      t.timestamps
    end
  end
end
