# frozen_string_literal: true

json.extract! tema, :id, :name, :description, :created_at, :updated_at
json.url tema_url(tema, format: :json)
