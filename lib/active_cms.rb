require 'active_cms/engine'
require 'tinymce-rails'
require 'tinymce-rails-langs'
require 'friendly_id'
require 'ancestry'

require 'rack/cache'
require 'dragonfly'

# include helper for use in frontend
require File.dirname(__FILE__) + '/../app/helpers/active_cms/pages_helper.rb'

module ActiveCms

  def self.setup
    yield self
  end
  
end

