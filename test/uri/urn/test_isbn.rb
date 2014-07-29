require 'minitest/autorun'
require 'uri/urn/isbn'

module URI
  module URN
    class TestISBN < MiniTest::Unit::TestCase
      def setup
        @isbn_string = '978-1937785499'
      end

      def test_parse
        uri = URI.parse("urn:isbn:#{@isbn_string}")
        assert_instance_of(ISBN, uri)
        assert_equal('urn', uri.scheme)
        assert_equal('isbn', uri.nid)
        assert_equal(@isbn_string, uri.nss)

        assert_raises(URI::InvalidComponentError) do
          URI.parse("urn:isbn:#{@isbn_string.chop}")
        end
      end

      def test_build
        uri = URI::URN::ISBN.build([@isbn_string])

        assert_instance_of ISBN, uri
        assert_equal('urn', uri.scheme)
        assert_equal('isbn', uri.nid)
        assert_equal(@isbn_string, uri.nss)
        assert_raises(URI::InvalidComponentError) do
          URI::URN::ISBN.build([@isbn_string.chop])
        end
      end

      def test_equal
        a = URI.parse('urn:isbn:193435693X')
        b = URI.parse('urn:isbn:193435693X')
        assert_equal(a, b)

        a = URI.parse('urn:isbn:978-4274064616')
        b = URI.parse('urn:isbn:9784274064616')
        assert_equal(a, b)
      end
    end
  end
end
