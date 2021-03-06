module ActiveCms
  class PagesController < ActiveCms::ApplicationController
    
    def show
      @page = ActiveCms::Page.find_by_slug(params[:id])
      unless @page
        not_found
      else
        @view_template_id = @page.view_template_id if !@page.view_template_id.nil? && @page.view_template_id > 0
        @title = @page.title
        @meta_keywords = @page.meta_keywords || 'meta'
        @meta_description = @page.meta_description || 'meta'
      end

    end
    
  end
end