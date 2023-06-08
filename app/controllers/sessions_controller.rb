class SessionsController < ApplicationController
  def show
    @user = User.find(params[:id])
    setup_video_call_token
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
