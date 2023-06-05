class Friendship < ApplicationRecord
  has_one :participant_one, class: 'User', foreign_key: :participant_one_id
  has_one :participant_two, class: 'User', foreign_key: :participant_two_id
  has_many :messages
end
