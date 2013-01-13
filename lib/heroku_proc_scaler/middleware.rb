require 'active_record'
require 'heroku-api'
require 'rack'
require 'heroku_proc_scaler'

module HerokuProcScaler
  
  class Middleware

    attr_reader :app, :web_reporter

    def initialize(app)
      @app = app
      @web_reporter = HerokuProcScaler::WebReporter.new
    end

    def call(env)
      begin
        scale(env)
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
      app.call(env)
    end

    def scale(env)
      puts "checking queue depth..."
      if depth = queue_depth(env)
        puts "   reporting."
        @web_reporter.current_queue_depth depth
      end
    end 

    def queue_depth(env)
      env["HTTP_X_QUEUE_DEPTH"].nil? ? nil : env["HTTP_X_QUEUE_DEPTH"].to_i
    end 

  end

end