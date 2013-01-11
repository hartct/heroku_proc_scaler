require 'active_record'
require 'heroku-api'
require 'rack'
require 'heroku_proc_scaler'

module HerokuProcScaler
  
  class Middleware

    attr_reader :app

    def initialize(app)
      @app = app
    end

    def call(env)
      begin
        EventMachine.defer { scale(env) }
      rescue Exception => e
        puts e.message
        puts e.backtrace.inspect
      end
      app.call(env)
    end

    def scale(env)
      if queue_depth(env).nil?
        puts "no queue depth header found"
      else
        puts "Heroku Queue Depth = #{queue_depth}" 
      end
    end 

    def queue_depth(env )
      env["HTTP_X_QUEUE_DEPTH"].nil? ? nil : env["HTTP_X_QUEUE_DEPTH"].to_i
    end 

  end

end