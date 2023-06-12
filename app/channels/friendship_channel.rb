class FriendshipChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    friendship = Friendship.find(params[:id])
    stream_for friendship
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    console.log("Unsubscribed from the chatroom")
    this.channel.unsubscribe()
  end
end
