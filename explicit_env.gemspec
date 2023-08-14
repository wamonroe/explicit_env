require_relative "lib/explicit_env/version"

Gem::Specification.new do |spec|
  spec.name = "explicit_env"
  spec.version = ExplicitEnv::VERSION
  spec.authors = ["Alex Monroe"]
  spec.email = ["alex@monroepost.com"]

  spec.summary = "Simple library to explicitly define and access environmental variables used in an application."
  spec.description = spec.summary
  spec.homepage = "https://github.com/wamonroe/explicit_env"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "CHANGELOG.md", "MIT-LICENSE", "Rakefile", "README.md"]
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 6.1.0"
end
