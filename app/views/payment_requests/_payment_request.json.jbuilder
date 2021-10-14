json.extract! payment_request, :id, :user_id, :status, :comment, :created_at, :updated_at
json.url payment_request_url(payment_request, format: :json)
