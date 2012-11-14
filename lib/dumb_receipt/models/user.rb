require 'dumb_receipt/models/model'

module DumbReceipt
  module Models
    class User < Model
      set_accessors %w[
        uuid
        first_name
        last_name
        email
        profile_image_url
        sign_in_count
        receipts_count
        offers_count
        created_at
        updated_at
        confirmed_at
        current_sign_in_at
        last_sign_in_at
        current_sign_in_ip
        last_sign_in_ip
      ]
    end
  end
end

