class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.string :status
      t.references :participant_one, null: false, foreign_key: {to_table: :users}
      t.references :participant_two, null: false, foreign_key: {to_table: :users}
      t.timestamps
    end
  end
end
