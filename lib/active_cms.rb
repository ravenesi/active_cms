require 'active_cms/engine'
require 'tinymce-rails'
require 'tinymce-rails-langs'
require 'friendly_id'
require 'ancestry'

require 'rack/cache'
require 'dragonfly'

#override the standard from ckeditor
require 'active_cms/backend/dragonfly'

module ActiveCms

  def self.setup
    yield self
  end
  
end

