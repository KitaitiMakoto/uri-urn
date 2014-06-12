require 'uri/urn'

module URI
  module URN
    class ISBN < Generic
      ISBN10_PATTERN = '(?:\d+-\d+-\d+-\d)|(?:\d{9}[\dXx])'.freeze
      ISBN13_PATTERN = '(?:\d{3}-\d+-\d+-\d+-\d)|(?:\d{3}-\d{10})|(?:\d{13})'.freeze
      NSS_PATTERN = "#{ISBN10_PATTERN}|#{ISBN13_PATTERN}".freeze

      def normalize!
        super
        set_nss(self.nss.upcase.gsub('-', ''))
      end
    end

    @@nids['ISBN'] = ISBN
  end
end

