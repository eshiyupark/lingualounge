class Language < ApplicationRecord
  belongs_to :user_language
  belongs_to :session
end
