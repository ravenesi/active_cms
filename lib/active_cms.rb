require 'active_cms/engine'
require 'ckeditor'
require 'friendly_id'
require 'ancestry'

require 'rack/cache'
require 'dragonfly'

module ActiveCms

  def self.setup
    yield self
  end
  
end