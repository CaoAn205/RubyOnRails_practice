class Room < ApplicationRecord
  belongs_to :user
  has_many :room_messages, dependent: :destroy, inverse_of: :room
end
