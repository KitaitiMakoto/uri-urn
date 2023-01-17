URI::URN
========

This library adds URN scheme support for standard bundled URI library described in [RFC 2141][rfc2141].

Installation
------------

Install it yourself as:

    $ gem install uri-urn

Or add this line to your application's Gemfile:

    gem 'uri-urn'

And then execute:

    $ bundle

Usage
-----

For known Namespace IDs such as UUID, URI parses and returns URNs of them.

    urn = URI.parse('urn:uuid:01787092-e668-4234-bde9-15444f9c5560')
    urn.class # => URI::URN::UUID
    urn.scheme # => "urn"
    urn.nid # => "uuid"
    urn.nss # => "01787092-e668-4234-bde9-15444f9c5560"

    isbn = URI.parse('urn:isbn:978-4274064616')
    isbn.class # => URI::URN::ISBN
    isbn.scheme # => "urn"
    isbn.nid #=> "isbn"
    isbn.nss #=> "978-4274064616"
    isbn.normalize! # => "9784274064616"

For unknown Namespace URN, returns URI::URN::Generic object.

    URI.parse('urn:dummy:specific-string') # => #<URI::URN::Generic:0x007f3028cc3c10 URL:urn:dummy:specific-string>

### Supported Namespaces

Currently supported:

* UUID([RFC 4122][rfc4122])
* ISBN

### Adding Namespaces

Define subclass of `URI::URN::Generic` and register it:

    module URI::URN
      class IETF < Generic
        # subclass definition here...
      end

      @@nids['IETF'] = IETF
    end

Now you can parse IETF URN URI as `URI::URN::IETF`:

    URI.parse('urn:ietf:rfc:4122') # => #<URI::URN::IETF:0x007f6226e02470 URL:urn:ietf:rfc:4122>

Contributing
------------

1. Clone it ( https://gitorious.org/uri-ext/uri-urn/clone )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Merge Request

[rfc2141]: http://www.ietf.org/rfc/rfc2141.txt
[rfc4122]: http://www.ietf.org/rfc/rfc4122.txt
