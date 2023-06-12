class Message < ApplicationRecord
  belongs_to :user
  belongs_to :friendship

  validates :content, presence: true, length: { maximum: 2000 }

  def sender?(a_user)
    user.id == a_user.id
  end
end
