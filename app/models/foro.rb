# frozen_string_literal: true

class Foro < ApplicationRecord
  validates :description, presence: true, length: { minimum: 10 }, allow_blank: false
  validates :title, presence: true, length: { minimum: 3 }, allow_blank: false

  has_many :temas, dependent: :destroy

  def self.search(search)
    where('title LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%")
  end
end
