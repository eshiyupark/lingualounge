class Message < ApplicationRecord
  belongs_to :user
  belongs_to :friendship

  validates :content, presence: true, length: { maximum: 2000 }
end
