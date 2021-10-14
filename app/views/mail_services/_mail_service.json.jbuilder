json.extract! mail_service, :id, :title, :body, :created_at, :updated_at
json.url mail_service_url(mail_service, format: :json)
