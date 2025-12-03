class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  validates :title, :location, :start_datetime, :end_datetime, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
