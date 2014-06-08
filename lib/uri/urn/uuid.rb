require 'uri/urn'

module URI
  module URN
    class UUID < Generic
      NSS_PATTERN = "[#{PATTERN::HEX}]{8}-[#{PATTERN::HEX}]{4}-[#{PATTERN::HEX}]{4}-[#{PATTERN::HEX}]{4}-[#{PATTERN::HEX}]{12}".freeze

      alias uuid nss

      #
      # Generate UUID and build URI::URN::UUID with it
      #
      # Currently only version 4 is supported
      #
      def self.generate
        require 'securerandom' unless defined? SecureRandom
        build(nss: SecureRandom.uuid)
      end

      def normalize!
        super
        set_nss(self.nss.downcase)
      end
    end

    @@nids['UUID'] = UUID
  end
end
