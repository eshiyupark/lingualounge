module PagesHelper
  def dark_bg_page?
    params[:controller] == "pages" || (params[:controller] == "user_languages" && params[:action] == "edit_language")
  end
end
