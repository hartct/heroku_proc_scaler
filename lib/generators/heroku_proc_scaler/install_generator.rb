require 'rails/generators'
require 'rails/generators/migration'

module HerokuProcScaler
  class InstallGenerator < Rails::Generators::Base
    include Rails::Generators::Migration
    desc "Creates database migrations needed for HerokuProcScaler"
    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end
     
    def self.next_migration_number(dirname) #:nodoc:
      if ActiveRecord::Base.timestamped_migrations
        Time.now.utc.strftime("%Y%m%d%H%M%S")
      else
        "%.3d" % (current_migration_number(dirname) + 1)
      end
    end


    # Every method that is declared below will be automatically executed when the generator is run
    
    def create_migration_file
      f = File.open File.join(File.dirname(__FILE__), 'templates', 'schema.rb')
      schema = f.read; f.close
      
      schema.gsub!(/ActiveRecord::Schema.*\n/, '')
      schema.gsub!(/^end\n*$/, '')

      f = File.open File.join(File.dirname(__FILE__), 'templates', 'migration.rb')
      migration = f.read; f.close
      migration.gsub!(/SCHEMA_AUTO_INSERTED_HERE/, schema)
      tmp_dir = Dir.tmpdir
      tmp = File.open "#{tmp_dir}/~migration_ready.rb", "w"
      tmp.write migration
      tmp.close

      migration_template  "#{tmp_dir}/~migration_ready.rb",
                          "db/migrate/create_heroku_proc_scaler_tables.rb"
      remove_file "#{tmp_dir}/~migration_ready.rb"
    end

    def copy_initializer_file
      copy_file 'initializer.rb', 'config/initializers/heroku_proc_scaler.rb'
    end


    def update_application_template
    
    end
    
  end
end
