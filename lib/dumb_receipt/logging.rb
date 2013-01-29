require 'logger'

module DumbReceipt
  class Logging < Sinatra::Base

    LOG_FORMAT = %{%s - %s [%s] "%s %s%s %s" %d %s\n}

    after { log }

    private

    def log
      logger.info  access_log
      logger.debug debug_log
    end

    def logger

      # $spec_out is a StringIO defined in spec/spec_helper.rb. If it exists,
      # we're in a spec and not an app, so talk to it instead of polluting the
      # output for specs.
      #
      @@logger ||= Logger.new($spec_out || $stdout).tap do |logger|
        logger.formatter = Logger::Formatter.new()
      end
    end

    ##
    # Returns a hash of some basic debugging information
    #
    def debug_log
      {
        request: {
          env: {
            'HTTP_X_SR_AUTH' => env['HTTP_X_SR_AUTH']
          },
          params: params
        }
      }
    end

    ##
    # Returns a formatted log line. This is mostly copied from Rack::CommonLogger.
    #
    def access_log
      LOG_FORMAT % [
        env['HTTP_X_FORWARDED_FOR'] || env["REMOTE_ADDR"] || "-",
        env["REMOTE_USER"] || "-",
        Time.now.strftime("%d/%b/%Y %H:%M:%S"),
        env["REQUEST_METHOD"],
        env["PATH_INFO"],
        env["QUERY_STRING"].empty? ? "" : "?"+env["QUERY_STRING"],
        env["HTTP_VERSION"],
        status.to_s[0..3],
        extract_content_length
      ]
    end

    ##
    # Returns a formatted log line. This is copied from Rack::CommonLogger.
    #
    def extract_content_length
      value = headers['Content-Length'] or return '-'
      value.to_s == '0' ? '-' : value
    end
  end
end
