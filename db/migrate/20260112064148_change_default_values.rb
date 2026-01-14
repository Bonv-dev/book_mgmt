class ChangeDefaultValues < ActiveRecord::Migration[8.1]
  def change
    change_column_default :users,       :enabled,       true
    change_column_default :users,       :is_admin,      false
    change_column_default :users,       :is_librarian,  false
    change_column_default :floors,      :enabled,       true
    change_column_default :cabinets,    :enabled,       true
    change_column_default :steps,       :enabled,       true
    change_column_default :categories,  :enabled,       true
    change_column_default :books,       :enabled,       true
  end
end
