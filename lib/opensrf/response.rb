### INTRO

module Opensrf

  class Response

    attr_accessor :headers, :body, :from, :thread, :parsed

    def initialize(headers, body)
      begin
        @headers, @body = headers.split("\n"), JSON.parse(body)
        @from = @headers.grep(/X-OpenSRF-from/)[0].split(":")[1].strip
        @thread = @headers.grep(/X-OpenSRF-thread/)[0].split(":")[1].strip
        @parsed = {}
        @body.each do |osrfMessage|
          type = osrfMessage['__p']['type'].downcase
          @parsed[type] = {}
          @parsed[type]['status'] = osrfMessage['__p']['payload']['__p']['status']
          @parsed[type]['status_code'] = osrfMessage['__p']['payload']['__p']['statusCode']
          @parsed[type]['content'] = osrfMessage['__p']['payload']['__p']['content']
        end
      rescue
        'ERROR constructing response ...'
      end
    end

    def [](key)
      @parsed[key]
    end

    def to_j
      JSON.generate([@headers, @body])
    end

    alias :to_json :to_j

  end

end