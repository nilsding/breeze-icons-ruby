# frozen_string_literal: true

require_relative "breeze_icons/version"
require_relative "breeze_icons/data"

module BreezeIcons
  class Error < StandardError; end
  class NoSuchIcon < Error; end

  class Icon
    attr_reader :name

    def initialize(name, size: 16)
      aliased_name = Data::ICONS.dig(:aliases, size.to_s, name)
      @name = aliased_name || name
      @icon = Data::ICONS.dig(:icons, size.to_s, @name)
      @size = size

      unless @icon
        error_message = ["did not find icon ", name.inspect, aliased_name ? " (aliased to #{aliased_name.inspect})" : nil, ", size #{size.inspect}"].compact.join
        raise NoSuchIcon, error_message
      end
    end

    def to_svg(size: @size) = "<svg #{attributes svg_params(size:)}>#{path}</svg>"

    def path = "<path #{attributes path_params}></path>"

    def svg_params(size:) = {
      class:         "breeze-icon breeze-icon-#@name",
      version:       "1.1",
      viewBox:       @icon[:view_box] || "0 0 #@size #@size",
      width:         size,
      height:        size,
      "aria-hidden": true,
    }.compact

    def path_params = {
      d:         @icon[:path],
      transform: @icon[:transform],
    }.compact

    private

    def attributes(hash) = hash.map { "#{_1}=#{_2.to_s.inspect}" }.join(" ")
  end
end
