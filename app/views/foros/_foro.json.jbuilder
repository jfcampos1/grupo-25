# frozen_string_literal: true

json.extract! foro, :id, :title, :description, :created_at, :updated_at
json.url foro_url(foro, format: :json)
