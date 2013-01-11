# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "heroku_proc_scaler/version"

Gem::Specification.new do |s|
  s.name        = "heroku_proc_scaler"
  s.version     = HerokuProcScaler::VERSION
  s.authors     = ["Chris Hart"]
  s.email       = ["hartct@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Generic Heroku process scaling}
  s.description = %q{Provides a wrapped for web and worker dynos}

  s.rubyforge_project = "heroku_proc_scaler"

  s.files = [
    'README.md',
    'LICENSE.txt'
  ]
  s.files += Dir['lib/**/*.rb']
  s.files += Dir['lib/**/*.yml']
  s.files += Dir['*.rb']
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec", "~> 2.11"
  s.add_development_dependency "vcr", "~> 2.2"
  s.add_development_dependency "fakeweb", "~> 1.3"
  s.add_runtime_dependency "event_machine", "~> 0.3"
  s.add_runtime_dependency "heroku-api", "~> 0.3"
end
