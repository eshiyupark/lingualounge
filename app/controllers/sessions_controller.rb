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
    unless params[:sessions_ids].present?
      # When you first enter the queue page
      @sessions = current_user.sessions.where(participant_two_id: nil)
      @sessions_ids = @sessions.map(&:id).to_json
    else
      @sessions_ids = JSON.parse(params[:sessions_ids])
      @sessions = @sessions_ids.map { |id| Session.find(id) }
      @sessions.each do |session|
        respond_to do |format|
          if session.participant_two_id == nil
            format.html { "false" }
            format.json # Follow the classic Rails flow and look for a create.json view
          else
            format.html { "matched" }
            format.json # Follow the classic Rails flow and look for a create.json view
          end
        end
      end
    end
    # in the js controller, connect(),
      # create a setTimeout()
      # that would call this route again but asking for a text response
      # the request would also send a session_ids array through the params
      # In the rails controller, check if any of the sessions have participant two
      # If there is, send the html for the video call view and...
      # in js controller, change the outerHTML to the response
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
