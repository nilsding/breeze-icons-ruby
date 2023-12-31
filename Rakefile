# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/test_*.rb"]
end

desc "generate data file"
task :generate_data_file do
  require "nokogiri"
  require "pp"

  breeze_icons_path = File.expand_path("./vendor/breeze-icons/icons", __dir__)

  icons = {
    icons:   {},
    aliases: {},
  }

  puts "==> reading svgs ..."
  Dir["#{breeze_icons_path}/**/*.svg"].sort.each do |file|
    icon_name = File.basename(file, ".svg")
    category, size, *rest = File.dirname(file.delete_prefix("#{breeze_icons_path}/")).split("/")

    if File.symlink?(file)
      alias_to = File.basename(File.readlink(file), ".svg")
      icons[:aliases][size] ||= {}
      icons[:aliases][size][icon_name] ||= alias_to
      next
    end

    doc = Nokogiri::XML::Document.parse(File.read(file))
    path_nodes = doc.css("svg path")
    unless path_nodes.size == 1
      # puts "ignoring #{category}/#{size}/#{icon_name} as it has #{path_nodes.size} path nodes"
      next
    end

    path = path_nodes.first

    transform = path.parent["transform"]
    # if the parent group has a transform the path might inverse it
    transform = nil if transform && path["transform"]

    icons[:icons][size] ||= {}
    icons[:icons][size][icon_name] = {
      category:,
      class:          path["class"],
      path:           path["d"],
      stroke_linecap: path["stroke-linecap"],
      stroke_width:   path["stroke-width"],
      transform:      transform,
      view_box:       doc.first_element_child["viewBox"],
    }.compact
  end

  puts "==> cleaning up aliases"
  icons[:aliases].each do |size, aliases|
    aliases.reject! do |from, to|
      next false if icons[:icons][size]&.key?(to)

      true
    end
  end

  puts "==> generating data file"
  File.open(File.expand_path("./lib/breeze_icons/data.rb"), "w") do |f|
    f.puts <<~RUBY
      # frozen_string_literal: true
      #
      # generated by `rake generate_data_file`

      module BreezeIcons
        module Data
    RUBY
    f.print "    ICONS = "
    PP.pp icons, f
    f.puts <<~RUBY
        end
      end
    RUBY
  end

  puts "==> stats"
  icons[:icons].each do |size, icons|
    puts "%5s: %5s icons" % [size, icons.size]
  end
  icons[:aliases].each do |size, aliases|
    puts "%5s: %5s aliases" % [size, aliases.size]
  end
end

desc "generate a demo page"
task :generate_demo_page do
  require_relative "./lib/breeze_icons"

  puts "==> generating demo.html"
  File.open("./demo.html", "w") do |f|
    f.puts <<~HTML
      <!doctype html>
      <html>
      <head>
      <meta charset="utf-8">
      <title>breeze-icons-ruby showcase</title>
      <style>
      @media(prefers-color-scheme: dark) {
        body {
          background: #000;
          color: #fff;
          fill: #fff; /* this is for the SVG icons */
        }
        input {
          background: #000;
          color: #fff;
          border: 1px solid #aaa;
        }
      }
      .iconlist {
        display: flex;
        flex-wrap: wrap;
      }
      .icon {
        width: 15em;
        border: solid 1px;
        margin: .25em;
        padding: .25em;
        text-align: center;
        height: 15em;
        overflow-y: scroll;
      }
      .icon > tt {
        font-weight: bold;
      }
      .nojs {
        display: none;
      }
      </style>
      </head>
      <body>
      <h1>breeze-icons-ruby showcase</h1>
      <div class="nojs">
      filter: <input oninput="filter(this)">
      <style id="filterstyle"></style>
      </div>
      <script>
      document.querySelectorAll(".nojs").forEach(elem => elem.classList.remove("nojs"));
      const jsstyle = document.getElementById("filterstyle");
      function filter(elem)
      {
        if (elem.value == "" || elem.value.indexOf('"') > -1)
        {
          jsstyle.innerText = "";
          return;
        }
        jsstyle.innerText = `.icon:not([class*="${elem.value}"]) { display: none; }`;
      }
      </script>
    HTML

    data = BreezeIcons::Data::ICONS
    data[:icons].each do |size, icons|
      f.puts "<h2>#{size}</h2>"
      grouped_icons = icons.group_by { _2[:category] }.transform_values(&:to_h)
      grouped_icons.keys.sort.each do |category|
        f.puts "<h3>#{category}</h3>"
        f.puts %(<div class="iconlist">)
        grouped_icons[category].each_key do |name|
          aliases = data[:aliases][size]&.select { _2 == name }&.map(&:first)
          class_list = ["icon", "icon-#{name}", *aliases&.map { "icon-#{_1}" }].compact.join(" ")
          f.print %(<div class="#{class_list}">)
          icon = BreezeIcons::Icon.new(name, size:)
          f.print icon.to_svg
          f.print "<br><tt>#{name}</tt>"
          if aliases && !aliases.empty?
            f.print "<br><small>"
            f.print aliases.map { "<tt>#{_1}</tt>" }.join("<br>")
            f.print "</small>"
          end
          f.puts "</div>"
        end
        f.puts "</div>"
      end
    end

    f.puts <<~HTML
      </body>
      </html>
    HTML
  end
end

task default: %i[generate_data_file test]
