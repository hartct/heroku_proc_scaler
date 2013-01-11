module HerokuProcScaler
  class Engine < Rails::Engine

    config.mount_at = '/heroku_proc_scaler'
    config.widget_factory_name = 'Heroku Proc Scaler'
        
  end
end