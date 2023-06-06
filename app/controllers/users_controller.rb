class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  # get users/:id users#show
end
