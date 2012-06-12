### INTRO

module Opensrf
  
  class Message
    
    attr_reader :method, :params, :message

    def initialize(method, params, type)
      @method, @params, @type = method, params, type
      construct_message
    end

    def method=(method)
      @method = method
      construct_message
    end

    def params=(params)
      @params = params
      construct_message
    end

    def type=(type)
      @type = type
      construct_message
    end

    def to_j
      JSON.generate @message
    end

    alias :to_json :to_j

    :private

    def construct_message
      @message = [{
        '__c' => 'osrfMessage',
        '__p' => {
          'threadTrace' => 0,
          'type' => @type,
          'payload' => {
            '__c' => 'osrfMethod',
            '__p' => {
              'method' => @method,
              'params' => @params,
            },
          },
          'locale' => 'en-US',
        },
      }]
    end

  end

end