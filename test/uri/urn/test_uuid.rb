require 'minitest/autorun'
require 'uri/urn/uuid'
require 'securerandom'

module URI
  module URN
    class TestUUID < MiniTest::Unit::TestCase
      def setup
        @uuid_string = SecureRandom.uuid
      end

      def test_parse
        uri = URI.parse("urn:uuid:#{@uuid_string}")
        assert_instance_of(UUID, uri)
        assert_raises(URI::InvalidURIError) do
          URI.parse 'urn:uuid:'
        end
        assert_raises(URI::InvalidComponentError) do
          URI.parse 'urn:uuid:hello'
        end
      end

      def test_build
        uri = URI::URN::UUID.build([@uuid_string])
        assert_equal('urn', uri.scheme)
        assert_equal('uuid', uri.nid)
        assert_equal(@uuid_string, uri.uuid)

        uri = URI::URN::UUID.build(nid: 'dummy', nss: @uuid_string)
        assert_equal('urn', uri.scheme)
        assert_equal('uuid', uri.nid)
        assert_equal(@uuid_string, uri.nss)

        assert_raises(URI::InvalidComponentError) do
          URI::URN::UUID.build(['hello'])
        end
      end

      def test_equal
        a = URI.parse("urn:uuid:#{@uuid_string}")
        b = URI.parse("urn:uuid:#{@uuid_string}".upcase)
        assert_equal(a, b)
      end

      def test_components
        uri = URI.parse("urn:uuid:#{@uuid_string}")
        assert_equal("uuid:#{@uuid_string}", uri.opaque)
      end

      def test_generate
        uri = UUID.generate
        assert_equal('urn', uri.scheme)
        assert_equal('uuid', uri.nid)
        assert_match(/\A#{UUID::NSS_PATTERN}\z/, uri.uuid)
      end
    end
  end
end
