class FriendshipsController < ApplicationController

  def index
    @friendships = current_user.friendships
    @friendships_and_buddies = @friendships.map do |friendship|
      if friendship.participant_one == current_user
        buddy = friendship.participant_two
      else
        buddy = friendship.participant_one
      end
      {
        friendship: friendship,
        buddy: buddy
      }
    end
  end

  def create
    @friend_id = params[:friend_id]
    @friendship = Friendship.new(status: "pending", participant_one_id: current_user.id, participant_two_id: @friend_id)
    @friendship.save
    redirect_to user_path(@friend_id) if @friendship.save
  end

  def update # refactor this so that only the status is changeable by trigger
    @friendship = Friendship.find(params[:id])
    @friendship.update(friendship_params)
  end

  def destroy #if friendship.status is rejected then trigger this action
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
  end

  private

  def friendship_params
    params.require(:friendship).permit(:participant_one_id, :participant_two_id, :status)
  end
end
