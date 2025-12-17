class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  validates :title, :location, :start_datetime, :end_datetime, presence: true
  validates :capacity, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  def participants_count
    participations.count
  end
  
  def remaining_capacity
    capacity - participants_count
  end
  
  def full?
    remaining_capacity <= 0
  end
  
  def participating?(user)
    return false unless user
    participations.exists?(user_id: user.id)
  end
end
