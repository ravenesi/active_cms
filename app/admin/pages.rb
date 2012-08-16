# encoding: utf-8
ActiveAdmin.register ActiveCms::Page, :as => 'CmsPage' do
  
  menu :label => 'active_cms.pages.label', :parent => 'active_cms.label', :if => proc{ defined?('can?') && can?(:manage, ActiveCms::Page) }
  
  config.batch_actions = false
  filter :title
  
  form do |f|
    f.inputs I18n.t("active_cms.pages.fields.sections.basic"), :class => 'basic' do
      
      f.input :title, :label => I18n.t("active_cms.pages.fields.title")
      f.input :slug, :label => I18n.t("active_cms.pages.fields.slug")
      f.input :view_template, :label => I18n.t("active_cms.pages.fields.view_template"), :collection => ViewTemplate.find(:all, :conditions => "identifier like 'cms_pages_%' and identifier <> 'cms_pages_show'")
    end

    f.inputs I18n.t("active_cms.pages.fields.body"), :class => 'inputs full-input' do
      f.input :body, :label => false, :input_html => { :class => :tinymce_cms_page }
    end
    
    f.inputs I18n.t("active_cms.pages.fields.sections.settings"), :class => 'settings' do
      f.input :parent_id, :label => I18n.t("active_cms.pages.fields.parent_id"), :as => :select, :collection => nested_set_options(ActiveCms::Page, f.object) {|i| "#{'-' * i.level} #{i.title}"  }
      
      f.input :skip, :label => I18n.t("active_cms.pages.fields.skip")
      f.input :menu, :label => I18n.t("active_cms.pages.fields.menu")
      f.input :redirect, :label => I18n.t("active_cms.pages.fields.redirect")
    end
    
    f.inputs I18n.t("active_cms.pages.fields.sections.meta"), :class => 'meta' do
      f.input :meta_title, :label => I18n.t("active_cms.pages.fields.meta_title")
      f.input :meta_keywords, :label => I18n.t("active_cms.pages.fields.meta_keywords")
      f.input :meta_description, :label => I18n.t("active_cms.pages.fields.meta_description")
    end
    
    f.buttons
  end
  
  sidebar :pages_tree, :only => :index
  
  # only show file in category
  controller do
    def scoped_collection
      ActiveCms::Page.where( :parent_id => (params[:page_id] || nil) )
    end
  end
  
  show :title => :show_title do |page|
    h3 page.title
    div do
      render :partial => "admin/cms_pages/preview", :locals => {:page => page }
    end
  end
  
  index do
    column '', :skip_icon, :sortable => false
    column '', :redirect_icon, :sortable => false
    column '', :menu_icon, :sortable => false
    column I18n.t("active_cms.pages.index.header.title"), :title, :sortable => false
    column I18n.t("active_cms.pages.index.header.slug"), :slug, :sortable => false
    column I18n.t("active_cms.pages.index.header.link"), :link, :sortable => false
    default_actions
  end
  
end