# Cex.io

CEX.IO API integration. Ruby gem.

## Installation

Add this line to your application's Gemfile:

    gem 'cexio'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cexio

## Usage

##How to use?

###1. Create your ruby project

###2. Add "require 'cexio'")

###3. Create class
```ruby
  api = CEX::API(username, api_key, api_secret)
```
```
username - your username on cex.io
api_key - your API key
api_secret - your API secret code
```
###4. Methods and parameters:

####a) API method parametrs
```
1. couple = ("GHS\BTC" | "BF1\BTC") currency pair
2. since = integer  return trades with tid >= since
3. order_id = integer
4. ptype = ("sell" | "buy") type of order
5. amount = float
6. price = float
```

####b) API methods
```
1. ticker(couple = 'GHS/BTC') - get ticker
2. order_book(couple = 'GHS/BTC') - get order
3. trade_history(since = 1, couple = 'GHS/BTC') -  get all order
4. balance() - get your balance
5. current_orders(couple = 'GHS/BTC') - get open order
6. cancel_order(order_id) - cancel order №order_id
7. place_order(ptype = 'buy', amount = 1, price = 1, couple = 'GHS/BTC') - create order
8. convert(couple = 'GHS/BTC', amount = 1) - Converts 1 GHS to BTC
```

####c) Full API documentation: https://cex.io/api

###5. Examples

####Connect and get balance:
```ruby
 # -*- encoding : utf-8 -*-
require 'rubygems'
require 'cexio'

cex = CEX::API.new(username, api_key, api_secret)
puts cex.balance

```
```json
{"timestamp": "1383379054", "BTC": {"available": "0.04614310", "orders": "0.00170000"}, "GHS": {"available": "0.02000000"}}
```

####Get balance:
```ruby
puts cex.balance
```
```json
{"timestamp": "1383379054", "BTC": {"available": "0.04614310", "orders": "0.00170000"}, "GHS": {"available": "0.02000000"}}
```

####Get API ticker:
```ruby
puts cex.ticker('GHS/BTC')
```
```json
{"volume": "7154.78339022", "last": "0.1078", "timestamp": "1383379041", "bid": "0.10778", "high": "0.10799999", "low": "0.10670076", "ask": "0.10780000000000001"}
```

####Convert:
```ruby
puts cex.convert('GHS/BTC', 1)
```
```json
{"amnt": "0.00168199"}
```

####Get order book:
```ruby
puts cex.order_book("BF1/BTC")
```
```json
{"timestamp": "1383378967", "bids": [["1.7", "0.30100000"], ["1.67", "0.00011000"], ["0.8", "0.02070000"], ["0.1002", "0.27748002"], ["0.1", "0.10000000"], ["0.011", "0.30500000"], ["0.009", "1.00000000"], ["0.00171", "0.00100000"], ["0.0012", "1.00000000"], ["0.00116819", "0.50000000"], ["0.001002", "33.00000000"], ["0.001001", "53.00000000"], ["0.001", "3.00000000"], ["0.00097626", "36.00000000"], ["0.0006", "85.00000000"], ["0.00058409", "0.50000000"], ["0.0004889", "0.06823960"], ["0.0003", "1.00000000"], ["0.00029204", "0.90000000"], ["0.0001", "101.00000000"]], "asks": []}
```

####Trade history: (DEPRICATED)
```ruby
puts cex.trade_history(1,'BTC/GHS')
```
```json
[{"amount": "0.00000010", "price": "0.00849979", "date": "1398221957", "tid": 3628072}, {"amount": "0.00000010", "price": "0.00849979", "date": "1398221957", "tid": 3628072}]
```
Note: The first parameter is the `since` and is not optional, you will get a 5xx if you do not include it.  

####Archived Orders:
```ruby
puts cex.archived_orders("BTC/USD",status: 'd')
```
```json
[{"id"=>"123", "type"=>"buy", "time"=>"2017-12-13T11:47:58.671Z", "lastTxTime"=>"2017-12-13T11:48:58.693Z", "lastTx"=>"5193837266", "pos"=>nil, "status"=>"d", "symbol1"=>"BTC", "symbol2"=>"USD", "amount"=>"0.07192208", "price"=>"17409.22", "tfacf"=>"1", "fa:USD"=>"0.00", "ta:USD"=>"328.81", "remains"=>"0.00000000", "tfa:USD"=>"1.85", "tta:USD"=>"923.27", "a:BTC:cds"=>"0.07192208", "a:USD:cds"=>"1254.62", "f:USD:cds"=>"1.85", "tradingFeeMaker"=>"0", "tradingFeeTaker"=>"0.20", "tradingFeeUserVolumeAmount"=>"12391047", "orderId"=>"12345"}]
```

####Get your current active orders:
```ruby
puts cex.current_orders("BF1/BTC")
```
```json
[{"price": "1.7", "amount": "0.00100000", "time": "1383378514737", "type": "buy", "id": "6219104", "pending": "0.00100000"}]
```
Note: you can use either `current_orders` or `open_orders`.

####Place new order:
```ruby
puts cex.place_order("buy", 0.001, 1.7, "BF1/BTC")
```
```json
{"price": "1.7", "amount": "0.00100000", "time": 1383378987622, "type": "buy", "id": "6219145", "pending": "0.00100000"}
```

####Place another order (GHS/BTC):
```ruby
puts cex.place_order("buy", 0.01, 0.10789, "GHS/BTC")
```
```json
{"price": "0.10789", "amount": "0.01000000", "time": 1383379024072, "type": "buy", "id": "6219150", "pending": "0.00000000"}
```
####Get order details:
```ruby
puts cex.get_order(12345)
```
```json
{"id"=>"12345", "type"=>"buy", "time"=>1512911048632, "lastTxTime"=>"2017-12-10T13:04:08.632Z", "lastTx"=>"5169872761", "pos"=>nil, "user"=>"up12345", "status"=>"d", "symbol1"=>"BTC", "symbol2"=>"USD", "amount"=>"0.00000000", "amount2"=>"200.00", "remains"=>"0.00000000", "tfa:USD"=>"13.09", "tta:USD"=>"186.90", "a:BTC:cds"=>"0.01247797", "a:USD:cds"=>"200.00", "f:USD:cds"=>"13.09", "tradingFeeTaker"=>"7", "tradingFeeStrategy"=>"DefaultFok5", "orderId"=>"12345"}
```
####Get order details with transactions:
```ruby
puts cex.get_order_tx(12345)
```
```json
{"e"=>"get_order_tx", "ok"=>"ok", "data"=>{"id"=>"12345", "type"=>"buy", "time"=>1512911048632, "lastTxTime"=>1512911048632, "lastTx"=>"123456", "pos"=>nil, "user"=>"up1234", "status"=>"d", "symbol1"=>"BTC", "symbol2"=>"USD", "amount"=>"0.00000000", "amount2"=>"200.00", "remains"=>"0.00000000", "tfa:USD"=>"13.09", "tta:USD"=>"186.90", "a:BTC:cds"=>"0.01247797", "a:USD:cds"=>"200.00", "f:USD:cds"=>"13.09", "tradingFeeTaker"=>"7", "tradingFeeStrategy"=>"DefaultFok5", "orderId"=>"12345", "next"=>false, "vtx"=>[{"id"=>"123456", "type"=>"buy", "time"=>"2017-12-10T13:04:08.632Z", "user"=>"up1234", "c"=>"user:up1234:a:USD", "d"=>"order:12345:a:USD", "a"=>"0.01000000", "amount"=>"-199.99000000", "balance"=>"100.01000000", "symbol"=>"USD", "order"=>"12345", "buy"=>nil, "sell"=>nil, "pair"=>nil, "pos"=>nil, "cs"=>"100.01", "ds"=>0}, {"id"=>"123457", "type"=>"buy", "time"=>"2017-12-10T13:04:08.632Z", "user"=>"up1234", "c"=>"user:up1234:a:BTC", "d"=>"order:12345:a:BTC", "a"=>"0.00247797", "amount"=>"0.00247797", "balance"=>"0.01247797", "symbol"=>"BTC", "order"=>"12345", "buy"=>"12345", "sell"=>"123456", "pair"=>nil, "pos"=>nil, "cs"=>"0.01247797", "ds"=>0, "price"=>14980, "symbol2"=>"USD", "fee_amount"=>"2.60"}, {"id"=>"123458", "type"=>"buy", "time"=>"2017-12-10T13:04:08.632Z", "user"=>"up1234", "c"=>"user:up1234:a:BTC", "d"=>"order:12345:a:BTC", "a"=>"0.01000000", "amount"=>"0.01000000", "balance"=>"0.01000000", "symbol"=>"BTC", "order"=>"12345", "buy"=>"12345", "sell"=>"123564", "pair"=>nil, "pos"=>nil, "cs"=>"0.01000000", "ds"=>0, "price"=>14979.7, "symbol2"=>"USD", "fee_amount"=>"10.49"}]}}
```


####Cancel order:
```ruby
cex.cancel_order(6219145)
```
```json
True
```

####Get address:
```ruby
puts cex.get_address("BTC")
```
```json
{"e"=>"get_address", "ok"=>"ok", "data"=>"3A*********************a"}
```

####Get myfee:
```ruby
puts cex.get_myfee
```
```json
{"e"=>"get_myfee", "ok"=>"ok", "data"=>{"BTC:USD"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "ETH:USD"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "BCH:USD"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "BTG:USD"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "DASH:USD"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "XRP:USD"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "ZEC:USD"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "BTC:EUR"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "ETH:EUR"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "BCH:EUR"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "BTG:EUR"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "DASH:EUR"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "XRP:EUR"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "ZEC:EUR"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "BTC:GBP"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "ETH:GBP"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "BCH:GBP"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "DASH:GBP"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "ZEC:GBP"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "BTC:RUB"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "ETH:BTC"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "BCH:BTC"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "BTG:BTC"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "DASH:BTC"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "XRP:BTC"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "ZEC:BTC"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}, "GHS:BTC"=>{"buy"=>"0.25", "sell"=>"0.25", "buyMaker"=>"0.16", "sellMaker"=>"0.16"}}}
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
