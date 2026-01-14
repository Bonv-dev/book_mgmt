json.extract! log, :id, :status, :book_id, :user_id, :created_at, :updated_at
json.url log_url(log, format: :json)
