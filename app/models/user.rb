class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_languages, dependent: :destroy
  has_many :languages, through: :user_languages
  has_many :reviews
  has_many :messages
  has_many :friendships_created, class_name: "Friendship", foreign_key: :participant_one, dependent: :destroy
  has_many :friendships_received, class_name: "Friendship", foreign_key: :participant_two, dependent: :destroy
  has_many :sessions, foreign_key: :participant_one, dependent: :destroy
  has_many :inverse_sessions, class_name: "Session", foreign_key: :participant_two, dependent: :destroy

  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :gender, presence: true, inclusion: { in: ["male", "female", "prefer not to say"] }
  validate :validate_age

  def friendships
    friendships_created + friendships_received
  end

  def is_friend?(user)
    condition1 = Friendship.where(participant_one: user, participant_two: self).exists?
    condition2 = Friendship.where(participant_one: self, participant_two: user).exists?
    condition1 || condition2
  end

  # def friendship_status(user)
  #   is_friend(user)
  #   @friendship = Friendship.find(condition1.id).or(Friendship.find(condition2.id))
  #   return @friendship.status
  # end

  private

  def validate_age
    if date_of_birth.present? && date_of_birth > 18.years.ago.to_date
        errors.add(:date_of_birth, 'You should be over 18 years old.')
    end
  end
end
