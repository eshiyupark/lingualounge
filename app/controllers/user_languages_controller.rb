class UserLanguagesController < ApplicationController
  def new_language #new
    @user_language = UserLanguage.new
    @languages = Language.all - current_user.languages
    capitalize(@languages)
  end

 # note that flash error does not appear but will come back to this
  def create_language #create
    @name = params[:user_language][:language].reject(&:blank?) # @name is an array of languages user inputs
    if @name.blank?
      flash[:error] = "You must select at least one language"
    else
      @name.each do |language|
        @language = Language.find_by(name: language.downcase)
        @user_language = UserLanguage.new(user_language_params)
        @user_language.user = current_user
        @user_language.language = @language
        @user_language.save
        redirect_to root_path
      end
    end
  end

  def edit_language
    @user_languages = current_user.user_languages
  end

  def update_language #update
    id_array = params[:user_language_ids]
    id_array.each do |id|
      id.to_i
      @language = UserLanguage.find(id)
      @language.update(active: true)
    end
    redirect_to sessions_queue_path
  end

  # come back to this depending on the users/edit page
  # def destroy_language
  #   @language = UserLanguage.find(params[:language_id])
  #   @language.destroy
  # end

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
