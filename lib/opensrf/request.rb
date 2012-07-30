### INTRO

module Opensrf

  class Request

    attr_accessor :host, :protocol, :translator, :prefix, :message, :headers

    def initialize(host, protocol = 'http', translator = '/osrf-http-translator', prefix = 'osrf-msg=')
      @host, @protocol, @translator, @prefix = host, protocol, translator, prefix
    end

    def set_message(method, params)
      @message = Opensrf::Message.new(method, params, 'REQUEST')
    end

    def set_service(service)
      @headers = Opensrf::Headers.new
      @headers['X-OpenSRF-service'] = service
    end

    def set_to(to)
      @headers = Opensrf::Headers.new
      @headers['X-OpenSRF-to'] = to
    end

    def send
      raise 'HEADERS and MESSAGE DATA must be set ...' unless @headers and @message
      request = @prefix + URI.escape(@message.to_json.to_s)
      pp request
      url = "#{@protocol}://" + @host + @translator
      begin
        c = Curl::Easy.http_post(url, request) do |curl| 
          curl.headers = @headers.headers
      end
      Opensrf::Response.new c.header_str, c.body_str
      rescue
        'ERROR executing request ...'
      end
    end

  end
  
end