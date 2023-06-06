class Session < ApplicationRecord
  belongs_to :language
  has_many :reviews
  belongs_to :participant_one, class_name: 'User', foreign_key: 'participant_one_id', required: true
  belongs_to :participant_two, class_name: 'User', foreign_key: 'participant_two_id', required: true
end
