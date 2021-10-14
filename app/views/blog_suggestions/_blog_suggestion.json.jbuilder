json.extract! blog_suggestion, :id, :title, :status, :description, :created_at, :updated_at
json.url blog_suggestion_url(blog_suggestion, format: :json)
