class MessagesController < ApplicationController

  def create
    @friendship = Friendship.find(params[:friendship_id])
    @message = Message.new(message_params)
    @message.friendship = @friendship
    @message.user = current_user
    if @message.save
      FriendshipChannel.broadcast_to(
        @friendship,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.user.id
      )
      head :ok

      # redirect_to friendship_path(@friendship)
    else
      render "friendships/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
