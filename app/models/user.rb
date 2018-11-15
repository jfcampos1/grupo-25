# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  before_create :confirmation_token
  mount_uploader :avatar, AvatarUploader
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validate :valid_content_type, on: 'update'
  has_many :active_relationships, class_name:  'Relationship',
                                  foreign_key: 'follower_id',
                                  dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :coments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_one :avatar, dependent: :destroy
  has_many :foros, dependent: :destroy

  has_many :moderators, dependent: :destroy
  has_many :moderator_requests, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :postratings, dependent: :destroy
  has_many :comentratings, dependent: :destroy

  has_many :favorites, dependent: :destroy

  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'followed_id',
                                   dependent:   :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :relationships, foreign_key: 'follower_id',
                           dependent: :destroy

  # Returns the hash digest of the given string.
  def follow(other_user)
    following << other_user
  end

  # Unfollows a user.
  def unfollow(other_user)
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
  end

  def self.digest(string)
    cost = BCrypt::Engine::MIN_COST
    return BCrypt::Password.create(string, cost: cost) if ActiveModel::SecurePassword.min_cost
    cost = BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def name_with_initial
    "#{name}."
  end

  def self.from_omniauth(auth)
    # Check out the Auth Hash function at https://github.com/mkdynamic/omniauth-facebook#auth-hash
    # and figure out how to get email for this user.
    # Note that Facebook sometimes does not return email,
    # in that case you can use facebook-id@facebook.com as a workaround
    email = auth[:info][:email] || "#{auth[:uid]}@facebook.com"
    user = where(email: email).first_or_initialize
    #
    # Set other properties on user here. Just generate a random password. User does not have to use it.
    # You may want to call user.save! to figure out why user can't save
    #
    # Finally, return user
    user.save && user
  end
  # Follows a user.

  private

  def valid_content_type
    message = 'is not a valid image file'
    errors.add(:avatar, message) unless %w[image/jpeg image/png].include? avatar.sanitized_file.content_type
  end

  def confirmation_token
    return self.confirm_token = SecureRandom.urlsafe_base64.to_s if confirm_token.blank?
  end
end
