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
    #ajax here to update button
  end

  # def show - to display all of messages between you and your friends (through friendships#show)
  # end

  def update
    @friend_id = params[:friend_id] #participant one
    @friendship = Friendship.where(participant_one_id: @friend_id, participant_two_id: current_user.id)[0]
    @friendship.update(status: 'accepted', participant_one_id: @friend_id, participant_two_id: current_user.id)
  end

  def destroy # decline or remove
    @friend_id = params[:friend_id]
    @friendship1 = Friendship.where(participant_one_id: @friend_id, participant_two_id: current_user.id).first
    @friendship2 = Friendship.where(participant_one_id: current_user.id, participant_two_id: @friend_id).first
    @friendship1.nil? ? @friendship2.destroy : @friendship1.destroy
  end

  private

  def friendship_params
    params.require(:friendship).permit(:participant_one_id, :participant_two_id, :status)
  end
end
