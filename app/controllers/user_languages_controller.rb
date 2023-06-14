class UserLanguagesController < ApplicationController
  #user_language selection page directly after sign up
  def new_language
    @user = current_user
  end

  #user_language creation action after initial sign up selection
  def setup_language
    @x_ids = params[:user_language][:user_languages].reject(&:blank?)
    @ids = @x_ids.map(&:to_i)
    if @ids.blank?
      @message = "You must select at least one language."
      @user = current_user
      render :new_language, status: :unprocessable_entity
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
      redirect_to root_path
      flash[:notice] = "You're all set!"
    end
  end

  #called when user updates languages in edit profile page
  def create_language
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
      redirect_to edit_user_registration_path
      flash[:alert] = "You must select at least one language"
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
