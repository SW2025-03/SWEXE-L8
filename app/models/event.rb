class Event < ApplicationRecord
  belongs_to :creator, class_name: 'User', optional: true
  has_many :participations, dependent: :destroy
  has_many :users, through: :participations

  validates :title, presence: true

  def spots_left
    return nil if capacity.nil?
    capacity - participations.where(status: [0,1]).count
  end
end
