require 'test/unit'
require 'uri/urn'

module URI

class TestURN < Test::Unit::TestCase
  def setup
    @uri_string = 'urn:nid:nss'
    @uri = URI.parse(@uri_string)
  end

  def test_build
    urn = nil
    assert_nothing_raised do
      urn = URI::URN.build(['nid', 'nss'])
    end
    assert_equal 'nid', urn.nid
    assert_equal 'nss', urn.nss
    assert_equal 'nid:nss', urn.opaque
  end

  def test_parse
    assert_nothing_raised do
      URI.parse @uri_string
    end
    [
      'urn:',
      'urn:sp ce'
    ].each do |uri_string|
      assert_raise InvalidURIError do
        URI.parse uri_string
      end
    end
  end

  def test_component
    assert_equal [:scheme, :nid, :nss], @uri.component
  end

  def test_components
    assert_equal 'urn', @uri.scheme
    assert_equal 'nid', @uri.nid
    assert_equal 'nss', @uri.nss
  end

  def test_equal
    assert_equal URI.parse('urn:nid:nss'), URI.parse('URN:NID:nss')

    assert (URI.parse('urn:nid:nss') == URI.parse('URN:NID:nss'))
  end
end

end
