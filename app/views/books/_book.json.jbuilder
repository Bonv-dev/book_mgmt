json.extract! book, :id, :enabled, :name, :isbn, :category_id, :step_id, :memo, :created_at, :updated_at
json.url book_url(book, format: :json)
