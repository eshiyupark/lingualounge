class ApplicationController < ActionController::Base
  include PagesHelper
  
  before_action :authenticate_user!
  before_action :configure_permitted_parameters,
                if: :devise_controller?

  # after_action :update_user_online, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :date_of_birth, :gender, :photo, :user_languages])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username, :date_of_birth, :gender, :photo, :user_languages])
  end

  # private

  # def update_user_online
  #   current_user.try :touch
  # end
end
