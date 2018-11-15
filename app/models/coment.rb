# frozen_string_literal: true

class Coment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :comentratings, dependent: :destroy
  validates :user_id, presence: true
  validates :content, presence: true
  default_scope -> { order(created_at: :desc) }
end
