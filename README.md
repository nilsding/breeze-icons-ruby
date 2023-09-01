# breeze-icons-ruby

This gem provides a subset of the excellent
[KDE Breeze Icons](https://invent.kde.org/frameworks/breeze-icons) as a gem.

It mostly only contains the "symbolic" icons which make it perfect for using it
on websites without resorting to an icon font.

Inspired by [octicons](https://github.com/primer/octicons/tree/main/lib/octicons_gem).

## Installation

Install the gem and add to the application's Gemfile by executing:

```sh
$ bundle add breeze_icons
```

If bundler is not being used to manage dependencies, install the gem by executing:

```sh
$ gem install breeze_icons
```

## Usage

```ruby
require "breeze_icons"
icon = BreezeIcons::Icon.new("media-playback-start")
icon.to_svg
# <svg class="breeze-icon breeze-icon-media-playback-start" version="1.1" viewBox="0 0 16 16" width="16" height="16" aria-hidden="true"><path d="m2 2v12l12-6z"></path></svg>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake test` to run the tests.  You can also run `bin/console` for an
interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and the created tag, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

To update the `breeze_icons` data file run:
```sh
rake generate_data_file
```

To generate a demo page with all the icons the gem supports:
```sh
rake generate_demo_page
```

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/nilsding/breeze-icons-ruby.  This project is intended to be
a safe, welcoming space for collaboration, and contributors are expected to
adhere to the [code of conduct](https://github.com/nilsding/breeze-icons-ruby/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the
[LGPLv3 Licence](https://opensource.org/license/lgpl-3-0/).

The icon data is licensed under the terms of LGPLv3 as per
https://invent.kde.org/frameworks/breeze-icons/-/blob/master/COPYING-ICONS.

## Code of Conduct

Everyone interacting in the BreezeIcons project's codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/nilsding/breeze-icons-ruby/blob/main/CODE_OF_CONDUCT.md).
