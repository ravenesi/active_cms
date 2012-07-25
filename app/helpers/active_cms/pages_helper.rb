module ActiveCms
  module PagesHelper

    def get_pages_list(slug, options = {})
      
      # variables
      exclude_self  ||= options[:exclude_self]  # should the current page be included ad first item? default: false
      no_link       ||= options[:no_link]       # should the current page be linked? default: false
      no_links      ||= options[:no_links]      # should the subpages be linked? default: false
      my_class      ||= options[:class]         # should the subpages be linked? default: false
      act_page      ||= options[:act_page]          # should the subpages be linked? default: false
      
      # create the page object
      if slug.respond_to?('id') && slug.id > 0
        page = slug
      elsif slug.to_i > 0
        page = ActiveCms::Page.find(slug.to_i)
      else
        page = ActiveCms::Page.find_by_slug(slug.to_s)
      end
      
      return "No page for '#{slug.to_s}' found." if !page 
      return "No pages in '#{slug.to_s}' found." if !page.children || page.children.size == 0
      
      page_link = (page.redirect != "")? page.redirect : page.link
      ret = "<ul class=\"#{page.slug} #{my_class}\">"
      ret << "<li>"+((!no_link)? "<a href=\"#{page_link}\">#{page.title}</a>" : "#{page.title}") + "<ul>" unless exclude_self
      page.children.where(:menu => true).each do |item|
        item_link = (item.redirect != "")? item.redirect : item.link
        
        # check if item shouled be marked as active, ToDo: dont't know why, but on local slow (indicies added)!
        active = (act_page && item.is_or_is_ancestor_of?(ActiveCms::Page.find(act_page)) ) ?  ' active' : ''
        
        ret << "<li class=\"#{item.slug}#{active}\"><a href=\"#{item_link}\">#{item.title}</a></li>" unless no_links
        ret << "<li class=\"#{item.slug}#{active}\">#{item.title}</li>" if no_links
      end
      ret << "</ul></li>" unless exclude_self
      ret << "</ul>"
      raw(ret)
    end
    
    def page_path_for(page)
      if page.new_record?
        admin_active_cms_pages_path(page).gsub('.', '')
      else
        admin_active_cms_page_path(page)
      end
    end
    
  end
end