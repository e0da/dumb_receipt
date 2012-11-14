require 'dumb_receipt/models/model'

module DumbReceipt
  module Models
    class Offer < Model
      set_accessors %w[
        uuid
        name
        contents
        image_url
        thumbnail_image_url
        is_read
        is_redeemed
        barcode_image_url
        coupon_code
        expires
        redeemed_at
        created_at
        updated_at
      ]
    end
  end
end
