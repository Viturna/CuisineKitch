json.extract! user, :id, :username, :password, :statut, :created_at, :updated_at
json.url user_url(user, format: :json)
