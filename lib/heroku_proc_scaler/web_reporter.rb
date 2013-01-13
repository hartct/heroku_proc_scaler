module HerokuProcScaler
  class WebReporter

    @last_report_time = 0
    @connection = nil

    def initialize
      @connection = ActiveRecord::Base.connection
    end

    def current_queue_depth depth
      report_queue_depth depth if WebReporter.should_report? depth
    end 

    def report_queue_depth depth
      update_stats_record depth
    end
  
    def self.should_report? depth
      time_to_report = (depth <= HerokuProcScaler.configuration.web_low_load_queue_max ? web_report_frequency_low_load : web_report_frequency_high_load)
      Time.now.to_i - @@last_report_time >= time_to_report
    end

    private 
    def delete_existing_stats
      @connection.delete "DELETE FROM procscaler_web_stats WHERE dyno_guid = '#{HerokuProcScaler.configuration.dyno_guid}'"
    end

    def update_stats_record depth
      puts "updating queue depth to #{depth}"
      @connection.insert_sql "INSERT INTO procscaler_web_stats (dyno_guid, last_queue_depth, created_at, updated_at) VALUES ('#{HerokuProcScaler.configuration.dyno_guid}', #{depth.to_i}, TIMESTAMP '#{Time.now.to_s(:db)}', TIMESTAMP '#{Time.now.to_s(:db)}')", nil, 'dyno_guid'
    end

  end
end