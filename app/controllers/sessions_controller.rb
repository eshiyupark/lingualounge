class SessionsController < ApplicationController
  def create
    language_ids = current_user.user_languages.map { |user_language| user_language.language.id if user_language.active? }.reject { |x| x == nil }
    if Session.where(participant_two_id: nil).where(language_id: language_ids).blank?
      language_ids.each do |id|
        session = Session.new(participant_one_id: current_user.id, language_id: id)
        session.save
      end
      redirect_to sessions_queue_path
    else
      @session = Session.where(participant_two_id: nil).where(language_id: language_ids).sample
      @session.participant_two = current_user
      if @session.save
        redirect_to sessions_show_path(@session)
      else
        # render some page with error
      end
    end
  end

  def show
    @session = Session.find(params[:id])
  end

  def queue
    @sessions = current_user.sessions.where(participant_two_id: nil)
    # Logic for matching with someone, and deleting all other sessions that are not matched
  end

  def destroy
    @sessions = current_user.sessions.where(participant_two_id: nil)
    if Session.destroy(@sessions.map(&:id))
      redirect_to root_path
    else
      # render some page with error
    end
  end
end
