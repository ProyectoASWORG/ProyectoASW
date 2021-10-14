json.extract! contribution, :id, :contribution_type, :text, :title, :user_email, :created_at, :updated_at
json.url contribution_url(contribution, format: :json)
