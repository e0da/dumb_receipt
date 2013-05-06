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
        remote_addr,
        remote_user,
        now,
        request_method,
        path_info,
        query_string,
        http_version,
        status_code,
        content_length
      ]
    end

    %w[
      request_method
      path_info
      http_version
    ].each do |meth|
      define_method meth.to_sym do  # def request_method
        env[meth.upcase]            #   env['REQUEST_METHOD']
      end                           # end
    end

    def content_length
      headers['Content-Length'].tap do |length|
        return length.to_s == '0' ? '-' : length
      end
    end

    def now
      Time.now.strftime '%d/%b/%Y %H:%M:%S'
    end

    def remote_addr
      env['HTTP_X_FORWARDED_FOR'] || env['REMOTE_ADDR'] || '-'
    end

    def remote_user
      env['REMOTE_USER'] || '-'
    end

    def query_string
      env['QUERY_STRING'].empty? ? '' : '?'+env['QUERY_STRING']
    end

    def status_code
      status.to_s[0..3]
    end
  end
end
