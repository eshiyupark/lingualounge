module PagesHelper
  def dark_bg_page?
    params[:controller] == "pages"
  end
end
