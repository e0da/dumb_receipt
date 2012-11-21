DumbReceipt [![Build Status](https://secure.travis-ci.org/SmartReceipt/dumb_receipt.png)](https://travis-ci.org/SmartReceipt/dumb_receipt) [![Dependency Status](https://gemnasium.com/SmartReceipt/dumb_receipt.png)](https://gemnasium.com/SmartReceipt/dumb_receipt) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/SmartReceipt/dumb_receipt)
===========

Serve up fake receipt and offer information for API testing

Queries
-------

### POST

* [/registration](/registration) gives you sample registration feedback
  * Most any POST request will result in success and give you a dummy
    auth_token
  * Setting a paramter called fail (i.e. `?fail=true`) will cause
    authentication to fail

To test post requests, you can use `curl`. Here are examples for success and
failure of registration:

    curl http://localhost:9393/registration -d ''
    curl http://localhost:9393/registration -d 'fail=true'

### GET

You can specify a `?limit=20`-style parameter to specify the number of results
that are returned. This will multiply and subtract the results to match the
limit that you specify. In the case of sync, both receipts and offers are
multiplied.

Because the point of DumbReceipt is to provide dummy testing data,
UUIDs and item counts won't necessarily line up between data types (e.g. all of
the offers listed by a receipt won't necessarily exist or be returned).

* [/sync](/sync) will give you sample _sync_ data.
* [/offers](/offers) will give you sample _offers_ data.
* [/receipts](/receipts) will give you sample _receipts_ data.

Development
-----------

### Setup

Install dependencies

    bundle

### Running it

Run it with rackup or passenger or thin or whatever:

    rackup

Or use shotgun so the server automatically restarts during development:

    shotgun

You can view this README in your browser for convenient access to shortcuts and
URLs by visiting the URL indicated by the web server, (e.g.
[http://localhost:9393](http://localhost:9393) or similar).

---

© [SmartReceipt](http://receipt.com) — Licensed under the [MIT license](http://opensource.org/licenses/MIT)
