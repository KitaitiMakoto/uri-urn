require 'test/unit'
require 'uri/urn/uuid'

module URI::URN

class TestUUID < Test::Unit::TestCase
  def setup
    @uuid_string = '01787092-e668-4234-bde9-15444f9c5560'
  end

  def test_parse
    uri = URI.parse("urn:uuid:#{@uuid_string}")
    assert_instance_of UUID, uri
    assert_raise URI::InvalidURIError do
      URI.parse 'urn:uuid:'
    end
    assert_raise URI::InvalidComponentError do
      URI.parse 'urn:uuid:hello'
    end
  end

  def test_build
    uri = nil
    assert_nothing_raised do
      uri = URI::URN::UUID.build([@uuid_string])
    end
    assert_equal 'urn', uri.scheme
    assert_equal 'uuid', uri.nid
    assert_equal @uuid_string, uri.uuid

    assert_nothing_raised do
      uri = URI::URN::UUID.build(nid: 'dummy', nss: @uuid_string)
    end
    assert_equal 'urn', uri.scheme
    assert_equal 'uuid', uri.nid
    assert_equal @uuid_string, uri.nss

    assert_raise URI::InvalidComponentError do
      URI::URN::UUID.build(['hello'])
    end
  end

  def test_equal
    assert (URI.parse("urn:uuid:#{@uuid_string}") == URI.parse("urn:uuid:#{@uuid_string}".upcase))
  end

  def test_components
    uri = URI.parse("urn:uuid:#{@uuid_string}")
    assert_equal "uuid:#{@uuid_string}", uri.opaque
  end

  def test_generate
    uri = UUID.generate
    assert_equal 'urn', uri.scheme
    assert_equal 'uuid', uri.nid
    assert_match /\A#{UUID::NSS_PATTERN}\z/, uri.uuid
  end
end

end
