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

  def edit_language
    @user_languages = current_user.user_languages
  end

  def update_language #update
    @user_languages = current_user.user_languages
    id_array = params[:user_language_ids].map(&:to_i)
    @user_languages.each do |user_language|
      if id_array.include?(user_language.id)
        user_language.update(active: true)
      else
        user_language.update(active: false)
      end
    end
    # after update then we need to go to session create which then goes to sessions/queue
    language_ids = @user_languages.map { |user_language| user_language.language.id if user_language.active? }.reject { |x| x == nil }
    if Session.where(participant_two_id: nil).where(language_id: language_ids).where.not(participant_one_id: current_user.id).blank?
      language_ids.each do |id|
        session = Session.new(participant_one_id: current_user.id, language_id: id)
        session.save
      end
      redirect_to sessions_queue_path
    else
      @session = Session.where(participant_two_id: nil).where(language_id: language_ids).sample
      @session.participant_two = current_user
      if @session.save
        redirect_to sessions_show_path(@session)
      else
        # render some page with error
      end
    end
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
