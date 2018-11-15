# frozen_string_literal: true

json.extract! coment, :id, :date, :content, :created_at, :updated_at
json.url coment_url(coment, format: :json)
