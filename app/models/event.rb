class Event < ApplicationRecord
  validates :title, presence: true
  validates :start_datetime, presence: true
  validates :end_datetime, presence: true
  validates :organizer, presence: true
  validates :creator_id, presence: true
  
  belongs_to :creator, class_name: "User", optional: true
end
