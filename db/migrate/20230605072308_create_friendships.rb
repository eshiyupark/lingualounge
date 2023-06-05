class CreateFriendships < ActiveRecord::Migration[7.0]
  def change
    create_table :friendships do |t|
      t.string :status
      t.integer :participant_one_id
      t.integer :participant_two_id

      t.timestamps
    end
  end
end
