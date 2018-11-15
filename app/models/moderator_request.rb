# frozen_string_literal: true

class ModeratorRequest < ApplicationRecord
  belongs_to :user
  belongs_to :tema
end
