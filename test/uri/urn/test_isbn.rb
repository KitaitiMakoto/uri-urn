require 'test/unit'
require 'uri/urn/isbn'

module URI::URN

class TestISBN < Test::Unit::TestCase
  def setup
    @isbn_string = '978-1937785499'
  end

  def test_parse
    uri = URI.parse("urn:isbn:#{@isbn_string}")

    assert_instance_of ISBN, uri
    assert_equal 'urn', uri.scheme
    assert_equal 'isbn', uri.nid
    assert_equal @isbn_string, uri.nss
    assert_raise URI::InvalidComponentError do
      URI.parse("urn:isbn:#{@isbn_string.chop}")
    end
  end

  def test_build
    uri = URI::URN::ISBN.build([@isbn_string])

    assert_instance_of ISBN, uri
    assert_equal 'urn', uri.scheme
    assert_equal 'isbn', uri.nid
    assert_equal @isbn_string, uri.nss
    assert_raise URI::InvalidComponentError do
      URI::URN::ISBN.build([@isbn_string.chop])
    end
  end

  def test_equal
    assert URI.parse('urn:isbn:193435693X') == URI.parse('urn:isbn:193435693X')
    assert URI.parse('urn:isbn:978-4274064616') == URI.parse('urn:isbn:9784274064616')
  end
end

end
