class User < ApplicationRecord
  has_secure_password

  has_many :events, foreign_key: 'creator_id', dependent: :destroy
  has_many :participations, dependent: :destroy
  has_many :participated_events, through: :participations, source: :event

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
