class SessionsController < ApplicationController
  def create
    # Create session in only English, will need to be changed to be dynamic
    if Session.where(participant_two_id: nil).where(language_id: Language.where(name: "english")[0].id).blank?
      @session = Session.new(participant_one_id: current_user.id, language_id: Language.where(name: "english")[0].id)
      if @session.save
        redirect_to sessions_queue_path
      else
        # render the user_languages/options page with error
      end
    else
      @session = Session.where(participant_two_id: nil).where(language_id: Language.where(name: "english")[0].id)[0]
      @session.participant_two = current_user
      if @session.save
        redirect_to session_path(@session)
        # NOT WORKING - @SESSION DOESNT SEEM TO BE PASSING THROUGH
      else
        # render some page with error
      end
    end
  end

  def queue

  end
end
