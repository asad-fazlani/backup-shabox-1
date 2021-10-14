json.extract! wallet, :id, :amount, :status, :user_id, :created_at, :updated_at
json.url wallet_url(wallet, format: :json)
