# -*- encoding: utf-8 -*-
require File.expand_path('../lib/area_cn/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["kame"]
  gem.email         = ["chenhb2@qqw.com.cn"]
  gem.description   = %q{中国地区数据查询}
  gem.summary       = %q{中国地区数据查询}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "area_cn"
  gem.require_paths = ["lib"]
  gem.version       = AreaCN::VERSION

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'

  gem.add_dependency 'json', '~> 1.7.5'
  gem.add_dependency 'activesupport', '~> 3.2.6'

end
