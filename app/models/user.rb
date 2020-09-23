class User < ApplicationRecord
  has_many :posts, -> {order(:created_at => :desc)} , dependent: :destroy
  has_many :likes, -> {order(:created_at => :desc)}, dependent: :destroy
  has_many :comments, -> {order(:created_at => :desc)}, dependent: :destroy
  has_many :bookmarks, -> {order(:created_at => :desc)}, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_many :followeds, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :room_messages, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[facebook]
  gravtastic :email
  validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.search(term)
    if term
      where('name LIKE ?', term + '%')
    else
      nil
    end
  end

  def is_followed
    Followed.find_by(user_id: id)
  end
end
