class Friendship < ApplicationRecord
  has_many :messages
  belongs_to :participant_one, class_name: 'User', foreign_key: 'participant_one_id', required: true
  belongs_to :participant_two, class_name: 'User', foreign_key: 'participant_two_id', required: true
  validates :status, presence: true, inclusion: { in: ["pending", "accepted", "rejected"] }
  validate :not_yet_friends, on: :create


  private

  def not_yet_friends
    errors.add(:participant_one, "is already a friend!") if participant_one.is_friend?(participant_two)
  end
end
