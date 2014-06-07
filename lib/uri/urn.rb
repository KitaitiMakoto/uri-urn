require 'uri/generic'

module URI
  class URN < Generic
    COMPONENT = [:scheme, :nid, :nss]

    NID_PATTERN = '[\w\d][\w\d\-]{0,31}'.freeze
    URN_CHARS_PATTERN = "[\\w\\d()+,\\-.:=@;$_!*%/?#]|#{PATTERN::ESCAPED}".freeze
    NSS_PATTERN = "(?:#{URN_CHARS_PATTERN})+".freeze
    URN_REGEXP = Regexp.new("\\A(?<nid>#{NID_PATTERN}):(?<nss>#{NSS_PATTERN})\\z").freeze

    attr_reader :nid, :nss

    @@nids = {}
    def self.nid_list
      @@nids
    end

    def self.build(args)
      tmp = Util.make_components_hash(self, args)
      tmp[:opaque] = "%{nid}:%{nss}" % tmp

      return super(tmp)
    end

    def initialize(*arg)
      super(*arg)
      self.opaque = @opaque
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
      if value !~ /\A#{NSS_PATTERN}\z/o
        raise InvalidComponentError, "bad component(expected nss component: #{value})"
      end
    end
  end

  @@schemes['URN'] = URN
end
