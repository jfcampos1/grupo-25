# frozen_string_literal: true

json.extract! favorite, :id, :user_id, :post_id, :created_at, :updated_at
json.url favorite_url(favorite, format: :json)
