json.extract! signup, :id, :first_name, :last_name, :email, :address, :address2, :city, :state, :zip, :phone, :photo_id, :selfie, :created_at, :updated_at
json.url signup_url(signup, format: :json)
