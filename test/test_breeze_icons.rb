# frozen_string_literal: true

require "test_helper"

class TestBreezeIcons < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::BreezeIcons::VERSION
  end

  def test_fetching_icons
    assert_equal ::BreezeIcons::Icon.new("application-x-ruby").name, "application-x-ruby"
  end

  def test_fetching_aliased_icons
    assert_equal ::BreezeIcons::Icon.new("folder-html").name, "globe"
  end

  def test_unknown_icon
    assert_raises(::BreezeIcons::NoSuchIcon) { ::BreezeIcons::Icon.new("paws") }
  end
end
