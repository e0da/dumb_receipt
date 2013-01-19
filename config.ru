$: << 'lib'

require 'dumb_receipt/app'

$stdout.sync = true

run DumbReceipt::App.new
