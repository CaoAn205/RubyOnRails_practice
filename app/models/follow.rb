class Follow < ApplicationRecord
  belongs_to :user
  has_one :followed, dependent: :destroy
end
