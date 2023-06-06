class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_languages
  has_many :languages, through: :user_languages
  has_many :reviews
  has_many :messages
  has_many :friendships, foreign_key: :participant_one
  has_many :inverse_friendships, class_name: "Friendship", foreign_key: :participant_two
  has_many :sessions, foreign_key: :participant_one
  has_many :inverse_sessions, class_name: "Session", foreign_key: :participant_two
end
