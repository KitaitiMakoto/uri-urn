require 'uri/generic'

module URI
  module URN
    class Generic < URI::Generic
      COMPONENT = [:scheme, :nid, :nss]

      NID_PATTERN       = /[\w\d][\w\d\-]{0,31}/
      URN_CHARS_PATTERN = /[\w\d\(\)\+\,\-\.\:\=\@\;\$\_\!\*\%\/\?\#]|#{URI::PATTERN::ESCAPED}/
      NSS_PATTERN       = /(?:#{URN_CHARS_PATTERN})+/
      URN_REGEXP        = /\A(?<nid>#{NID_PATTERN}):(?<nss>#{NSS_PATTERN})\z/

      attr_reader :nid, :nss

      def self.build(args)
        nid = self.to_s.sub(/\A.*::/, '').downcase
        unless nid == 'generic'
          if args.kind_of?(Array)
            args = [nid] + args
          elsif args.kind_of?(Hash)
            args[:nid] = nid
          end
        end
        tmp = Util.make_components_hash(self, args)
        tmp[:scheme] = 'urn'
        tmp[:opaque] = "%{nid}:%{nss}" % tmp

        return super(tmp)
      end

      def initialize(*arg)
        super(*arg)
        if arg[-1]
          self.opaque = @opaque
        end
      end

      def nid=(value)
        check_nid(value)
        set_nid(value)
        value
      end

      def nss=(value)
        check_nss(value)
        set_nss(value)
        value
      end

      def opaque=(value)
        check_opaque(value)

        if URN_REGEXP =~ value
          self.nid = $~['nid']
          self.nss = $~['nss']
        else
          raise InvalidURIError, "bad URI(nid nor nss not set?): #{self}"
        end

        set_opaque(value)
        value
      end

      def normalize!
        super
        set_nid(self.nid.downcase)
      end

      protected

      def set_nid(nid)
        @nid = nid
      end

      def set_nss(nss)
        @nss = nss
      end

      private

      def check_nid(value)
        if value !~ /\A#{NID_PATTERN}\z/o
          raise InvalidComponentError, "bad component(expected nid component: #{value})"
        end

        return true
      end

      def check_nss(value)
        if value !~ /\A#{self.class::NSS_PATTERN}\z/ # Do not set `o'(optimize) switch. This regepx may be overwritten at subclasses
          raise InvalidComponentError, "bad component(expected nss component: #{value})"
        end

        return true
      end

    end
  end
end
