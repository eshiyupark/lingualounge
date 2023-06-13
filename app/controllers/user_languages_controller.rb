class UserLanguagesController < ApplicationController
  #creats languages fine but errors do not render properly
  def create_language #create
    @current_ids = current_user.languages.map(&:id)
    @x_ids = params[:user_language][:user_languages].reject(&:blank?)
    @ids = @x_ids.map(&:to_i)
    @delete_ids = (@current_ids - @ids)
    unless @delete_ids.blank? || @ids.blank?
      @delete_ids.each do |id|
        object = UserLanguage.where(language_id: id).where(user_id: current_user.id)[0]
        object.destroy
      end
    end
    if @ids.blank?
      flash[:notice] = "You must select at least one language"
      # FIX THIS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    else
      @ids.each do |id|
        unless current_user.languages.map(&:id).include?(id)
          @language = Language.find(id)
          @user_language = UserLanguage.new(user_language_params)
          @user_language.user = current_user
          @user_language.language = @language
          @user_language.save
        end
      end
      redirect_to edit_user_registration_path
      flash[:notice] = "Successfully saved languages"
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
