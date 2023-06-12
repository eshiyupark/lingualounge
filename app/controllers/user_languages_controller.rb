class UserLanguagesController < ApplicationController
  before_action :set_user

  def new_language #new
    @user_language = UserLanguage.new
    @all_languages = Language.all
    capitalize(@all_languages)
  end

  def create_language #create
    raise
    @name = params[:user_language][:language].downcase
    @language = Language.where(name: @name)[0]
    @user_language = UserLanguage.new(user_language_params)
    @user_language.user_id = @user.id
    @user_language.language_id = @language.id
    if @user_language.save
      redirect_to
    else
      render :new
    end
  end

  def set_language #index
    @all_user_languages = @user.languages
  end

  # keepsrouting to 'get' (set_language), raise ticket from here onwards
  def update_language #update
    @language = Language.find(params[:language_id])
    raise
    @user_language = @language.id
    @user_language.update(active: true)
  end

  def destroy_language #destroy
    @language = Language.find(:language_id)
    @language.destroy
  end

  private

  def user_language_params
    params.require(:user_language).permit(:language_id, :user_id, :active)
  end

  def set_user
    @user = current_user
  end

  def capitalize(array)
    @language_names = array.map do |language|
      language.name.capitalize
    end
    return @language_names
  end
end
