# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gitlab/ci/version'

Gem::Specification.new do |gem|
  gem.name          = "gitlab_ci"
  gem.version       = GitlabCi::VERSION
  gem.summary       = %q{Gitlab is a Ruby wrapper and CLI for the GitLab API}
  gem.description   = %q{Gitlab is a Ruby wrapper and CLI for the [GitLab-CI API](https://gitlab.com/gitlab-org/gitlab-ee/tree/master/doc/ci/api).}
  gem.license       = "MIT"
  gem.authors       = ["Christo De Lange"]
  gem.email         = "rubygems@dldinternet.com"
  gem.homepage      = "http://github.com/dldinternet/gitlab_ci"

  gem.files         = `git ls-files`.split($/)

  `git submodule --quiet foreach --recursive pwd`.split($/).each do |submodule|
    submodule.sub!("#{Dir.pwd}/",'')

    Dir.chdir(submodule) do
      `git ls-files`.split($/).map do |subpath|
        gem.files << File.join(submodule,subpath)
      end
    end
  end
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'gitlab', '~> 3.6', '>= 3.6.2'

  gem.add_development_dependency 'bundler', '~> 1.10'
  gem.add_development_dependency 'rake', '~> 10.0'
  gem.add_development_dependency 'rspec', '~> 3.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'
end
