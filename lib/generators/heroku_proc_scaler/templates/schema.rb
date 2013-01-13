ActiveRecord::Schema.define(:version => 0) do

    create_table :procscaler_web_stats, :force => true do |t|
      t.string    :dyno_guid, :limit => 36, :null => false
      t.integer   :last_queue_depth, :null => false
      t.timestamps
    end
    add_index :procscaler_web_stats, :dyno_guid

    create_table :procscaler_worker_stats, :force => true do |t|
      t.string    :process_name, :limit => 100, :null => false, :unique => true
      t.string    :dyno_guid, :limit => 36, :null => false
      t.integer   :last_queue_depth, :null => false
      t.timestamps
    end
    add_index :procscaler_worker_stats, :dyno_guid

end
