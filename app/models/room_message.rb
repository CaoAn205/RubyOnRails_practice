class RoomMessage < ApplicationRecord
  belongs_to :room, -> {order(:created_at => :desc)}, inverse_of: :room_messages
  belongs_to :user
end
