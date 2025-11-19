class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum status: { provisional: 0, confirmed: 1, cancelled: 2 }

  validates :user_id, uniqueness: { scope: :event_id, message: "は既にこのイベントに申込済みです" }
end
