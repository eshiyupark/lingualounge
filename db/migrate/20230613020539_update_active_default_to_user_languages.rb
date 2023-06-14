class UpdateActiveDefaultToUserLanguages < ActiveRecord::Migration[7.0]
  def change
    change_column_default :user_languages, :active, from: true, to: false
  end
end
