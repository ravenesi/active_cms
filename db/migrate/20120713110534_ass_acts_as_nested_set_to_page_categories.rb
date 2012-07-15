class AssActsAsNestedSetToPageCategories < ActiveRecord::Migration
  def change
    
    change_column :active_cms_pages, :ancestry, :integer
    rename_column :active_cms_pages, :ancestry, :parent_id
    
    add_column :active_cms_pages, :lft, :integer
    add_column :active_cms_pages, :rgt, :integer
    add_column :active_cms_pages, :depth, :integer
    
    ActiveCms::Page.rebuild!
    
  end
end
