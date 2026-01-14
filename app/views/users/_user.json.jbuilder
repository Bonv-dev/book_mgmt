json.extract! user, :id, :enabled, :name, :is_admin, :is_librarian, :created_at, :updated_at
json.url user_url(user, format: :json)
