require 'test/unit'
require 'fluent/log'
require 'fluent/test'
require 'fluent/plugin/filter_has_keys'

class HasKeysFilterTest < Test::Unit::TestCase
  include Fluent

  def setup
    Fluent::Test.setup
  end

  TAG = 'test'

  def create_driver(conf)
    Fluent::Test::FilterTestDriver.new(Fluent::HasKeysFilter).configure(conf, TAG)
  end

  def test_emit_with_essential_keys
    return unless defined? Fluent::Filter

    driver = create_driver(%[ keys hoge, foo ])
    es = Fluent::MultiEventStream.new

    time = Time.parse("2016-05-06 11:22:33 UTC").to_i
    driver.run do
      driver.filter({"hoge" => "fuga", "foo" => "bar"})
      driver.filter({"hoge" => "fuga"})
      driver.filter({"foo" => "bar"})
      driver.filter({"spam" => "ham"})
      driver.filter({"hoge" => "fuga", "foo" => "bar", "spam" => "ham"})
    end

    filtered_records = driver.filtered_as_array
    assert_equal 2, filtered_records.length
    assert_equal({"hoge" => "fuga", "foo" => "bar"}, filtered_records[0][2])
    assert_equal({"hoge" => "fuga", "foo" => "bar", "spam" => "ham"}, filtered_records[1][2])
  end

  def test_emit_without_essential_keys
    return unless defined? Fluent::Filter

    driver = create_driver(%[ ])
    es = Fluent::MultiEventStream.new

    time = Time.parse("2016-05-06 11:22:33 UTC").to_i
    driver.run do
      driver.filter({"hoge" => "fuga", "foo" => "bar"})
      driver.filter({"hoge" => "fuga"})
      driver.filter({"foo" => "bar"})
      driver.filter({"spam" => "ham"})
      driver.filter({"hoge" => "fuga", "foo" => "bar", "spam" => "ham"})
    end

    filtered_records = driver.filtered_as_array
    assert_equal 5, filtered_records.length
    assert_equal({"hoge" => "fuga", "foo" => "bar"}, filtered_records[0][2])
    assert_equal({"hoge" => "fuga"}, filtered_records[1][2])
    assert_equal({"foo" => "bar"}, filtered_records[2][2])
    assert_equal({"spam" => "ham"}, filtered_records[3][2])
    assert_equal({"hoge" => "fuga", "foo" => "bar", "spam" => "ham"}, filtered_records[4][2])
  end

end
