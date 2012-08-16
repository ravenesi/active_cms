class AddViewTemplateToActiveCmsPage < ActiveRecord::Migration
  def change
    
    add_column :active_cms_pages, :view_template_id, :integer
    
  end
end
