require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Goodie2
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    # turn off warnings triggered by friendly_id
    I18n.enforce_available_locales = false

    config.time_zone = 'Eastern Time (US & Canada)'


    # CKEditor, WYSIWYG
    config.autoload_paths += %w(#{config.root}/app/models/ckeditor)
    # setup bower components folder for lookup
    config.assets.paths << Rails.root.join('vendor', 'assets', 'bower_components')
    
    # autoload lib path
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # fonts
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
    # images
    config.assets.precompile << /\.(?:png|jpg)$/
    # precompile vendor assets
    config.assets.precompile += %w( angle.js )

    # Precompile Assets
    config.assets.precompile += %w( base.js )
    config.assets.precompile += %w( pages.js )
    config.assets.precompile += %w( projects.js )
    config.assets.precompile += %w( cycles.js )
    config.assets.precompile += %w( requests.js )
    config.assets.precompile += %w( reviews.js )
    config.assets.precompile += %w( organizations.js ) 
    config.assets.precompile += %w( devise/*.js )
    config.assets.precompile += %w( applicant/base.js )
    config.assets.precompile += %w( programadmin/base.js )
    config.assets.precompile += %w( programmanager/base.js )

    config.assets.precompile += %w( base.css )
    config.assets.precompile += %w( pages.css )
    config.assets.precompile += %w( projects.css )
    config.assets.precompile += %w( cycles.css )
    config.assets.precompile += %w( requests.css )
    config.assets.precompile += %w( reviews.css )
    config.assets.precompile += %w( organizations.css ) 
    config.assets.precompile += %w( devise/*.css )
    config.assets.precompile += %w( applicant/base.css )
    config.assets.precompile += %w( programadmin/base.css )
    config.assets.precompile += %w( programmanager/base.css )


    # precompile themes
    config.assets.precompile += ['angle/themes/theme-a.css',
                                 'angle/themes/theme-b.css',
                                 'angle/themes/theme-c.css',
                                 'angle/themes/theme-d.css',
                                 'angle/themes/theme-e.css',
                                 'angle/themes/theme-f.css',
                                 'angle/themes/theme-g.css',
                                 'angle/themes/theme-h.css'
                                ]
  end
end
