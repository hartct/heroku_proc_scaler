HerokuProcScaler.configure do |config|

  config.min_web_dynos = 2
  config.max_web_dynos = 10
  config.worker_dynos = {
    :worker_name => "worker_name",
    :min_dynos => 1,
    :max_dynos => 5,
    :scaling_strategy => :command_invocation,
    :options => ["worker_name"]
  }
  config.web_report_frequency_low_load = 600
  config.web_report_frequency_high_load = 60
  config.web_low_load_queue_max = 1
end