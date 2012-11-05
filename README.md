DumbReceipt
===========

Serve up fake receipt and offer information for API testing

Setup
-----

Install dependencies

    bundle

Running it
----------

    rackup   # or passenger, or thin, or unicorn, or whatever

Development
-----------

Use shotgun to automatically restart the server during development:

    shotgun

Now you can view this README in your browser for convenient access to shortcuts
and URLs by visiting the URL indicated by shotgun, (e.g.
[http://localhost:9393](http://localhost:9393) or similar).

Queries
-------

### POST

* [/registration](/registration) gives you sample registration feedback
  * Most any POST request will result in success and give you a dummy
    auth_token
  * Setting a paramter called fail (i.e. `&fail=true`) will cause
    authentication to fail

To test post requests, you can use `curl`. Here are examples for success and
failure of registration:

    curl http://localhost:9393/registration -d ''
    curl http://localhost:9393/registration -d 'fail=true'

### GET

* [/sync](/sync) will give you sample _sync_ data.
* [/offers](/offers) will give you sample _offers_ data.
* [/receipts](/receipts) will give you sample _receipts_ data.

---

© [SmartReceipt](http://receipt.com) — [license](/LICENSE)
