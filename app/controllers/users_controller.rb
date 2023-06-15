class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user == current_user
      @profile_navbar_active = "d-flex flex-column justify-content-center align-items-center p-2 custom-navbar-border-bottom"
    end
  end

  def edit
    @user = User.find(params[:id])
  end
end
