class ChangeParticipantTwoNullForSession < ActiveRecord::Migration[7.0]
  def change
    change_column_null :sessions, :participant_two_id, true
  end
end
