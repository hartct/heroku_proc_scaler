require 'heroku_proc_scaler'

module HerokuProcScaler
  module Rails
    def self.initialize

      if defined?(::Rails.configuration) && ::Rails.configuration.respond_to?(:middleware)
        # rack stuff
      end

      HerokuProcScaler.configure(true) do |config|
        config.logger           = rails_logger
        config.environment_name = defined?(::Rails.env) && ::Rails.env || defined?(RAILS_ENV) && RAILS_ENV
        config.project_root     = defined?(::Rails.root) && ::Rails.root || defined?(RAILS_ROOT) && RAILS_ROOT
        config.framework        = defined?(::Rails.version) && "Rails: #{::Rails.version}" || defined?(::Rails::VERSION::STRING) && "Rails: #{::Rails::VERSION::STRING}"
      end
    end
  end
end

HerokuProcScaler::Rails.initialize