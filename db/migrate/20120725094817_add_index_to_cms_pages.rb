class AddIndexToCmsPages < ActiveRecord::Migration
  def change
    
    add_index :active_cms_pages, :lft
    add_index :active_cms_pages, :rgt
    add_index :active_cms_pages, :parent_id
    add_index :active_cms_pages, :depth
    
  end
end
