# AkamaiRestCcu

This is the Ruby wrapper for Akamai restful CCU API

## Installation

Add this line to your application's Gemfile:

    gem 'akamai_rest_ccu'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install akamai_rest_ccu

## Usage

    ccu = AkamaiRestCcu::Ccu.new("username", password")

    ccu.purge_urls(["http://www.strikingly.com/jobs"])

    ccu.purge_cpcode(['123456'], {:domain => 'staging'})

    ccu.purge_status('/ccu/v2/purges/123a-def-123-891-99aebc3')

    ccu.queue_length

## Contributing

1. Fork it ( https://github.com/strikingly/akamai_rest_ccu/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
