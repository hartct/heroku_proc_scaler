require 'yaml'
require 'heroku_proc_scaler'

module HerokuProcScaler

  if Object.const_defined?(:Rails) and Rails.const_defined?(:Railtie)

    # @private
    class Railtie < Rails::Railtie

      # configure our plugin on boot. other extension points such
      # as configuration, rake tasks, etc, are also available
      initializer "heroku_proc_scaler.initialize" do |app|
        app.config.middleware.use HerokuProcScaler::Middleware
      end
      generators do
        require "generators/heroku_proc_scaler/install_generator"
      end
    end

  end

end