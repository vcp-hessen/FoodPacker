# These helper methods can be called in your template to set variables to be used in the layout
# This module should be included in all views globally,
# to do so you may need to add this line to your ApplicationController
#   helper :layout
module LayoutHelper
  def title(page_title, show_title = true)
    content_for(:title) { h(page_title.to_s) }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

  def stylesheet(*args)
    content_for(:head) { stylesheet_link_tag(*args) }
  end

  def javascript(*args)
    content_for(:head) { javascript_include_tag(*args) }
  end
  
  def main_menu(menu_items)
    menu = ""
    menu_items.each_with_index do |controller,index|
      classes = ""
      if (index == 0)
        classes = "first"
      end
      if (params[:controller] == controller)
        classes += ", active"
      end 
      menu += content_tag(:li, link_to( t("#{controller}.plural"), url_for(:controller => controller)), :class => classes)
    end
    menu.html_safe
  end
end
