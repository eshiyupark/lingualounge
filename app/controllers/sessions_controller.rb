class SessionsController < ApplicationController
  def show
    session = Session.find(params[:id])
    if session.participant_one_id == current_user.id
      @user = session.participant_two
    else
      @user = session.participant_one
    end
    setup_video_call_token
  end

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


  def queue
    unless params[:sessions_ids].present?
      # When you first enter the queue page
      @sessions = current_user.sessions.where(participant_two_id: nil)
      @sessions_ids = @sessions.map(&:id).to_json
    else
      # When the JS controller makes AJAX calls
      @sessions_ids = JSON.parse(params[:sessions_ids])
      @sessions = @sessions_ids.map { |id| Session.find(id) }
      @sessions.each do |session|
        @session = session if session.participant_two_id != nil
      end
    end

    respond_to do |format|
      if @session
        format.text { render inline: @session.id.to_s }
      else
        format.text { render inline: "" }
      end
      format.html
    end
  end

  def destroy
    @sessions = current_user.sessions.where(participant_two_id: nil)
    if Session.destroy(@sessions.map(&:id))
      redirect_to root_path
    else
      # render some page with error
    end
  end

   private

  def setup_video_call_token
    # No chatting with yourself
    return if @user == current_user
    # raise
    twilio = TwilioService.new
    twilio.generate_token(current_user, @user)
    @twilio_jwt = twilio.jwt
    @room_id = twilio.room_id
    # console.log(ringing(@user,@room_id))
  end

end
