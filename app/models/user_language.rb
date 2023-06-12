class UserLanguage < ApplicationRecord
  belongs_to :user
  belongs_to :language
  validates :language_id, uniqueness: { scope: :user_id, message: "Already selected as your language" }
end
