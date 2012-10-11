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

Queries
-------

* [/sync.json](/sync.json) will give you sample _sync_ data.
* [/offers.json](/offers.json) will give you sample _offers_ data.
* [/receipts.json](/receipts.json) will give you sample _receipts_ data.

License
-------
Licensed under the [MIT License](http://www.opensource.org/licenses/MIT).

Copyright
---------

Copyright © 2012 [SmartReceipt](http://receipt.com)
