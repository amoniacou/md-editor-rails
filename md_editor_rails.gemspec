$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "md_editor_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "md_editor_rails"
  s.version     = MdEditorRails::VERSION
  s.authors     = ["Vadym Ievsieiev"]
  s.email       = ["v.ievsieiev@amoniac.eu"]
  s.homepage    = "https://github.com/amoniacou/md-editor-rails"
  s.summary     = "Markdown editor for Rails."
  s.description = "Simple and easy markdown editor for Rails."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rails', '< 6.0'
  s.add_dependency 'redcarpet', '~> 3.3.4'
  s.add_dependency 'dropzonejs-rails', '~> 0.7.3'
  s.add_dependency 'font-awesome-sass', '~> 4.3.0'

  s.add_development_dependency "sqlite3"
end
