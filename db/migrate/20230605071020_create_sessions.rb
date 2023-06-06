class CreateSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :sessions do |t|
      t.references :participant_one, null: false, foreign_key: {to_table: :users}
      t.references :participant_two, null: false, foreign_key: {to_table: :users}
      t.boolean :accept_one
      t.boolean :accept_two
      t.references :language, null: false, foreign_key: true

      t.timestamps
    end
  end
end
