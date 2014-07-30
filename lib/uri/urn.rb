require 'uri/urn/generic'

module URI
  module URN
    def self.component
      URI::URN::Generic::COMPONENT
    end

    def self.new(*arg)
      nid = (md = arg[6].match(URI::URN::Generic::URN_REGEXP)) && md['nid']
      @@nids[nid.to_s.upcase].new(*arg)
    end

    def self.build(args)
      tmp = Util.make_components_hash(self, args)
      @@nids[tmp[:nid].to_s.upcase].build(tmp)
    end

    @@nids = Hash.new(URI::URN::Generic)
    def self.nid_list
      @@nids
    end
  end

  @@schemes['URN'] = URN
end

require 'uri/urn/uuid'
require 'uri/urn/isbn'
