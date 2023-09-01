# frozen_string_literal: true

require_relative "lib/breeze_icons/version"

Gem::Specification.new do |spec|
  spec.name = "breeze_icons"
  spec.version = BreezeIcons::VERSION
  spec.authors = ["Georg Gadinger"]
  spec.email = ["nilsding@nilsding.org"]

  spec.summary = "A subset of the KDE Plasma Breeze icon set packaged as a gem"
  spec.description = "A subset of the KDE Plasma Breeze icon set packaged as a gem"
  spec.homepage = "https://github.com/nilsding/breeze-icons-ruby"
  spec.license = "LGPL-3.0-only"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nilsding/breeze-icons-ruby"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end.tap { _1 << "lib/breeze_icons/data.rb" }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
