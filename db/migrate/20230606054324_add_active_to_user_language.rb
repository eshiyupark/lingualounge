class AddActiveToUserLanguage < ActiveRecord::Migration[7.0]
  def change
    add_column :user_languages, :active, :boolean, default: true
  end
end
