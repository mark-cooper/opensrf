### INTRO

module Opensrf

  class Headers

    attr_accessor :headers

    def initialize(headers = {})
      @headers = headers
      @headers['X-OpenSRF-xid'] ||= Time.now
      @headers['X-OpenSRF-thread'] ||= '123456789'
    end

    def []=(key, value)
      @headers.delete('X-OpenSRF-service') if key == 'X-OpenSRF-to'
      @headers.delete('X-OpenSRF-to') if key == 'X-OpenSRF-service'
      @headers[key] = value
    end

  end

end