require 'dumb_receipt/handlers/base'
require 'base64'

module DumbReceipt
  module Handlers
    class Images < Base

      # A disgusting magenta rectangle png in Base64
      #
      BASE64_PNG = <<-BASE64
iVBORw0KGgoAAAANSUhEUgAAAUAAAAB4AQMAAAC5ALmdAAAABGdBTUEAALGPC/xhBQAAAAFzUkdC
AK7OHOkAAAAgY0hSTQAAeiYAAICEAAD6AAAAgOgAAHUwAADqYAAAOpgAABdwnLpRPAAAAAZQTFRF
/wD/////nxgy4AAAAAFiS0dEAf8CLd4AAAAJcEhZcwAAAEgAAABIAEbJaz4AAAAbSURBVFjD7cEx
AQAAAMKg9U/tbwagAAAAAIA3EzgAAQcWoRYAAAAldEVYdGRhdGU6Y3JlYXRlADIwMTItMTEtMjdU
MTM6MzA6MDMtMDg6MDBUS381AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDEyLTExLTI3VDEzOjMwOjAz
LTA4OjAwJRbHiQAAAABJRU5ErkJggg==
      BASE64

      get '/images/:id' do
        image_result
      end

      private

      def image_result
        if params[:fail]
          [404]
        else
          content_type :png
          Base64.decode64 BASE64_PNG
        end
      end
    end
  end
end
