class UserLanguagesController < ApplicationController
  def new_language #new
    @user_language = UserLanguage.new
    @all_languages = Language.all
    capitalize(@all_languages)
  end

  #creats languages fine but errors do not render properly
  def create_language #create
    @name = params[:user_language][:language].reject(&:blank?) # @name is an array of languages user inputs
    if @name.blank?
      flash[:error] = "You must select at least one language"
      render :new_language
    else
      @name.each do |language|
        @language = Language.where(name: language.downcase)[0]
        @user_language = UserLanguage.new(user_language_params)
        @user_language.user = current_user
        @user_language.language = @language
        if @user_language.save
          redirect_to root_path
        else
          render :new_language
        end
      end
    end
  end

  # keeps routing to 'get' (set_language), raise ticket from here onwards
  def update_language #update
    @language = UserLanguage.find(params[:language_id])
    raise
    @language.update(active: true)
  end

  def destroy_language #destroy
    @language = UserLanguage.find(params[:language_id])
    @language.destroy
  end

  private

  def user_language_params
    params.require(:user_language).permit(:user_id, :active, :language_id)
  end

  def capitalize(array)
    @language_names = array.map do |language|
      language.name.capitalize
    end
    return @language_names
  end
end
