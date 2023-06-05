class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.integer :participant_one_id
      t.integer :participant_two_id
      t.boolean :accept_one
      t.boolean :accept_two
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
