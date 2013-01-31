ActiveCms::Engine.routes.draw do
  
  match '/:id', :to => 'active_cms/pages#show'#, :as => :page
  
end
