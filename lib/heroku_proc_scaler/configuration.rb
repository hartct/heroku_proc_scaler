module HerokuProcScaler
  class Configuration
    OPTIONS = [:min_web_dynos, :max_web_dynos, :worker_dynos, :web_poll_frequency]

    # minimum number of web dynos; proc scaler will never scale below this number
    attr_accessor :min_web_dynos

    # maximum number of web dynos; proc scaler will never scale above this number
    attr_accessor :max_web_dynos

    # hash of worker dyno information including the worker_name, min_dynos and max_dynos
    attr_accessor :worker_dynos

    # how frequently a web dyno will report its queue depth if it's under "low load"
    attr_accessor :web_report_frequency_low_load

    # threshold for web dyno "low load"; anything <= this number will be considered low load,
    # anything > this number will be considered high load for the purposes of reporting 
    # load and for scaling
    attr_accessor :web_low_load_queue_max

    # how frequently a web dyno will report its queue depth if it's under "high load"
    attr_accessor :web_report_frequency_high_load

    attr_reader :dyno_guid

    def initialize
      generate_dyno_guid
    end

    private

    def generate_dyno_guid
      @dyno_guid ||= SecureRandom.uuid
    end
  end
end