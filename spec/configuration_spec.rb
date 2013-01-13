require 'spec_helper'

describe HerokuProcScaler::Configuration do
  before(:all) do
    # placeholder
  end

  it 'should store configuration settings' do
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

    HerokuProcScaler.configuration.min_web_dynos.should == 2
    HerokuProcScaler.configuration.max_web_dynos.should == 10
    HerokuProcScaler.configuration.worker_dynos.should == {
      :worker_name => "worker_name",
      :min_dynos => 1,
      :max_dynos => 5,
      :scaling_strategy => :command_invocation,
      :options => ["worker_name"]
    }
    HerokuProcScaler.configuration.web_report_frequency_low_load.should == 600
    HerokuProcScaler.configuration.web_report_frequency_high_load.should == 60
    HerokuProcScaler.configuration.web_low_load_queue_max.should == 1
    HerokuProcScaler.configuration.dyno_guid.should_not be_nil
  end
end