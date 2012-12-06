DumbReceipt [![Build Status](https://secure.travis-ci.org/SmartReceipt/dumb_receipt.png)](https://travis-ci.org/SmartReceipt/dumb_receipt) [![Dependency Status](https://gemnasium.com/SmartReceipt/dumb_receipt.png)](https://gemnasium.com/SmartReceipt/dumb_receipt) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/SmartReceipt/dumb_receipt)
===========

Serve up fake receipt and offer information for API testing

Queries
-------

### GET

You can specify a `?limit=20`-style parameter to specify the number of results
that are returned. This will multiply and subtract the results to match the
limit that you specify. In the case of sync, both receipts and offers are
multiplied.

Because the point of DumbReceipt is to provide dummy testing data,
UUIDs and item counts won't necessarily line up between data types (e.g. all of
the offers listed by a receipt won't necessarily exist or be returned).

* [/sync][] will give you sample _sync_ data.
* [/offers][] will give you sample _offers_ data.
* [/receipts][] will give you sample _receipts_ data.
* [/stats][] will give you sample _stats_ data.
* [/images/whatever.png][] will give you sample image. You can specify a
  `fail=yes` parameter to induce a 404 error. You can put pretty much anything
  after `/images/`. All requests retrieve the same magenta rectangle.

### POST

Parameters are ignored unless otherwise stated. The point is to give you
well-formatted data in response to requests.

* [/registration][] gives you sample registration feedback
  * Most any POST request will result in success and give you a dummy
    auth_token
  * Setting a paramter called fail (i.e. `?fail=true`) will cause
    authentication to fail
* Receipts
  * [/receipts/add][] to add a receipt. It supports 2 fail parameters.
    * Specify `fail=ReceiptalreadyAssociated` for a 403 error
    * Specify `fail=ReceiptNotFound` for a 404 error
  * [/receipts/email][] to email a receipt. It supports 2 fail parameters.
    * Specify `fail=ReceiptNotFound` for a 404 error
    * Specify `fail=InvalidEmailOrMissingReceiptUUID` for a 400 error
* Offers
  * [/offers/read][] to mark offers as read. It supports a `fail=yes`
    parameter to test failure.
  * [/offers/redeem][] to redeem an offer. It supports a `fail=yes` parameter to
    test failure.

To test POST requests, you can use `curl`. Here are examples for success and
failure of registration:

    curl http://localhost:9393/registration -d ''
    curl http://localhost:9393/registration -d 'fail=true'

### DELETE

* [/receipts/delete][] to delete a receipt. This supports a `fail=yes`
  parameter to test failure. Any other parameters are ignored.

To test DELETE requests, you can use `curl`. Here are examples for success and
failure of receipt deletion:

    curl http://localhost:9393/receipts/delete --request DELETE
    curl http://localhost:9393/receipts/delete --request DELETE -d 'fail=true'

Development
-----------

The project is open source and hosted at GitHub:
<https://github.com/SmartReceipt/dumb_receipt>

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
<http://localhost:9393> or similar).

---

© [SmartReceipt][] — Licensed under the [MIT license][]

[SmartReceipt]: http://receipt.com
[MIT license]:  http://opensource.org/licenses/MIT

[/registration]: /registration
[/sync]:         /sync
[/offers]:       /offers
[/receipts]:     /receipts
[/stats]:        /stats

[/images/whatever.png]: /images/whatever.png

[/receipts/add]:    /receipts/add
[/receipts/email]:  /receipts/email
[/receipts/delete]: /receipts/delete

[/offers/read]:   /offers/read
[/offers/redeem]: /offers/redeem
