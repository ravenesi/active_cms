module ActiveCms
  class PagesController < ActiveCms::ApplicationController
    
    def show
      @page = Page.find_by_slug(params[:id])
      unless @page
        not_found
      else
        @title = @page.title
        @meta_keywords = @page.meta_keywords || 'meta'
        @meta_description = @page.meta_description || 'meta'
      end
      
      # for special output
      @template_vars = @template_vars.merge({
        :page => Drops::Cms::PageDrop.new(@page)
      }) if @template_vars
      
    end
    
  end
end