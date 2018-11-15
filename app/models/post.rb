# frozen_string_literal: true

class Post < ApplicationRecord
  validates :content, presence: true, length: { minimum: 10 }, allow_blank: false
  validates :title, presence: true, length: { minimum: 3 }, allow_blank: false

  belongs_to :tema
  belongs_to :user
  has_many :coments, dependent: :destroy
  has_many :postratings, dependent: :destroy

  has_many :favorites, dependent: :destroy

  def present_date
    return if date.today
  end

  def self.search(search)
    where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%")
  end
end
