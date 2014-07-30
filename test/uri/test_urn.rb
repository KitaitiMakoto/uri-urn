require 'minitest/autorun'
require 'uri/urn'

module URI
  class TestURN < MiniTest::Unit::TestCase
    def setup
      @uri_string = 'urn:nid:nss'
      @uri = URI.parse(@uri_string)
    end

    def test_build
      urn = URI::URN.build(['nid', 'nss'])
      assert_equal('nid', urn.nid)
      assert_equal('nss', urn.nss)
      assert_equal('nid:nss', urn.opaque)
    end

    def test_parse
      URI.parse(@uri_string)

      ['urn:', 'urn:sp ce'].each do |uri_string|
        assert_raises(InvalidURIError) do
          URI.parse(uri_string)
        end
      end

      # Google OAuth 2 URN
      urn = URI.parse('urn:ietf:wg:oauth:2.0:oob')
      assert_equal('ietf', urn.nid)
      assert_equal('wg:oauth:2.0:oob', urn.nss)
      assert_equal('urn', urn.scheme)

      # Ensure we did not mess up the URI API
      uri = URI.parse('http://127.0.0.1:8080')
      assert_equal('http', uri.scheme)
      assert_equal('127.0.0.1', uri.host)
    end

    def test_component
      assert_equal([:scheme, :nid, :nss], @uri.component)
    end

    def test_components
      assert_equal('urn', @uri.scheme)
      assert_equal('nid', @uri.nid)
      assert_equal('nss', @uri.nss)
    end

    def test_equal
      a = URI.parse('urn:nid:nss')
      b = URI.parse('URN:NID:nss')
      assert_equal(a, b)
    end
  end
end
