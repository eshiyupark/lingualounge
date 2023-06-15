class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    @users = User.all
    @home_navbar_active = "custom-navbar-border-bottom"
  end
end
