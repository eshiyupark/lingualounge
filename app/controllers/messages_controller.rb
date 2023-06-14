class MessagesController < ApplicationController

  def create
    @friendship = Friendship.find(params[:friendship_id])
    @message = Message.new(message_params)
    @message.friendship = @friendship
    @message.user = current_user
    @buddy = @friendship.buddy(current_user)
    puts @buddy
    respond_to do |format|
      if @message.save
        FriendshipChannel.broadcast_to(
          @friendship,
          message: render_to_string(partial: "message", locals: { message: @message }),
          sender_id: @message.user.id,
          form: render_to_string(partial: "chat_form", locals: { message: Message.new, friendship: @friendship })
        )
        head :ok

        LastmessageChannel.broadcast_to(
          @friendship,
          message: render_to_string(partial: "friendships/message_preview",
                   locals: { message: @message.content, friendship: @friendship})
        )
        head :ok

        format.html { redirect_to friendship_path(@friendship) }
      else
        # render "friendships/show", status: :unprocessable_entity
        # format.turbo_stream
        format.html { render "friendships/show", status: :unprocessable_entity }
      end
      format.turbo_stream
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
