# frozen_string_literal: true

class Tema < ApplicationRecord
  validates :description, presence: true, length: { minimum: 10 }, allow_blank: false
  validates :name, presence: true, length: { minimum: 3 }, allow_blank: false

  belongs_to :foro
  has_many :posts, dependent: :destroy
  has_many :moderators, dependent: :destroy
  has_many :moderator_requests, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  def self.search(search)
    where('name LIKE ? OR description LIKE ?', "%#{search}%", "%#{search}%")
  end
end
