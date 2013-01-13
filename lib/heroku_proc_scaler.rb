require 'heroku_proc_scaler/middleware'
require 'heroku_proc_scaler/version'
require 'railtie_rack'
require 'heroku_proc_scaler/configuration'
require 'heroku_proc_scaler/web_reporter'

module HerokuProcScaler

  class << self

    attr_writer :configuration

    def configure
      if ActiveRecord::Base.connection.table_exists?('procscaler_web_stats') && ActiveRecord::Base.connection.table_exists?('procscaler_worker_stats')
        yield(configuration)
      elsif !( File.basename($0) == "rake" && ARGV.include?("db:migrate") ) # if this isn't a rake migration ...
        # tables haven't been created that are necessary for the proc scaler to work so we exit immediately
        puts "HerokuProcScaler requires the procscaler_worker_stats and procscaler_web_stats tables to be migrated."
        puts "Please run the migrations created by the generator first."
        exit
      end
    end

    def configuration
      @configuration ||= Configuration.new
    end
    
  end

end