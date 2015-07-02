# Set up gems listed in the Gemfile.
# See: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'

require 'sinatra'
require 'sinatra/flash'
require 'sinatra_more/markup_plugin'
require 'sinatra_more/render_plugin'

require 'erb'
require 'bcrypt'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'carrierwave/processing/rmagick'

if development?
  require 'sinatra/reloader'
  require 'byebug'
end

# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

# Set up Sinatra More
register SinatraMore::MarkupPlugin
register SinatraMore::RenderPlugin

# Set up CarrierWave
CarrierWave.configure do |config|
  config.permissions = 0666
  config.directory_permissions = 0777
  config.storage = :file
  config.root = APP_ROOT + 'public/'
  config.store_dir = 'uploads/'
end
CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

# Set up the controllers, helpers, and uploaders
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'uploaders', '*.rb')].each { |file| require file }

# Set up the database and models
require APP_ROOT.join('config', 'database')

# Monkey patch for strong parameters
class Hash
  def require(key)
    self.symbolize_keys!
    self[key].presence.symbolize_keys! || raise("Parameters missing! (Ref: #{key})")
  end

  def permit(*filters)
    params = self.class.new
    filters.each do |filter|
      params[filter] = self[filter] if has_key?(filter)
    end
    params
  end
end
