[![Gem Version](https://badge.fury.io/rb/coincheckup.svg)](https://badge.fury.io/rb/coincheckup)

# CoinCheckup

Ruby Gem that parses cryptocurrency information, ratings, and expert information from coincheckup.com.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coincheckup', '~> 0.1.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install 'coincheckup'

## Usage

### Coin Analytics

```ruby
CoinCheckup.analysis('funfair')

=> {:market=>
  {:id=>"funfair",
   :name=>"FunFair",
   :symbol=>"FUN",
   :rank=>"82",
   :price_usd=>"0.0528672",
   :price_btc=>"0.00000619",
   :"24h_volume_usd"=>"5903320.0",
   :market_cap_usd=>"238097416.0",
   :available_supply=>"4503688789.0",
   :total_supply=>"17173696076",
   :max_supply=>nil,
   :percent_change_1h=>"-2.99",
   :percent_change_24h=>"-4.32",
   :percent_change_7d=>"24.26",
   :last_updated=>"1518447551",
   :internal_id=>"funfair",
   :cmc_id=>"funfair",
   :price_eth=>6.2367372362488e-05,
   :market_percent=>0.00056801570025822,
   :first_trade_time=>1498539603,
   :first_price_usd=>0.01741,
   :avg_3mo_volume=>16461965.001914,
   :avg_3mo_mkt_cap=>287800043.20792,
   :growth_all_time=>3.0746927053418,
   :volume_change_24h=>72670,
   :mkt_cap_percent_change_24h=>0.00055857899073825,
   :mkt_cap_against_total_market_growth=>0.057928608886898,
   :price_change_btc_24h=>3.162e-08,
   :price_change_eth_24h=>5.0030781770443e-07,
   :percent_change_1mo=>-162.6582278481,
   :proof_type=>"N/A",
   :algorithm=>"N/A"},
 :top_coin_by_all_time_growth=>0,
 :categories=>["Gambling", "Gaming"],
 :tags=>[],
 :research=> { ... },
 ...
}

# Error response
CoinCheckup.analysis('blah')
=> {:code=>404, :error=>"Not Found", :message=>"invalid coin_id: blah"}
```

### Coin Categories

```ruby
CoinCheckup.categories

=> {
  :code=>200,
  :count=>123,
  data_version: '201802181189',
  :categories=> [
    {
      :id=>1,
      :type=>"Digital currency",
      :coins=> [
        "bitcoin",
        "ethereum",
        "litecoin",
        ... ],
    :count=>658,
    }]
  }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/kurt-smith/coincheckup. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the CoinCheckup project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kurt-smith/coincheckup/blob/master/CODE_OF_CONDUCT.md).
