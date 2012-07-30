module Opensrf

  class Session

    attr_reader :host, :fm_IDL

    def initialize(host = 'localhost')
      @host = host
      @fm_IDL = "http://#{@host}/reports/fm_IDL.xml"
    end

    def login(user, password)
      begin
        params = [user]
        method = 'open-ils.auth.authenticate.init'
        service = 'open-ils.auth'
        response = request service, method, params
        seed = response['result']['content']
        password = Digest::MD5.hexdigest(seed + Digest::MD5.hexdigest(password))
        params = [{"username" => user, "password" => password, "type" => "opac"}]
        method = 'open-ils.auth.authenticate.complete'
        service = 'open-ils.auth'
        response = request service, method, params
        return response['result']['content']['payload']['authtoken']
      rescue Exception => ex
        nil
      end
    end

    def request(service, method, params)
      o = Opensrf::Request.new @host
      o.set_service service
      # if params IS TYPEOF FIELDMAPPER CLASS -- ENCODE
      o.set_message method, params
      response = o.send
      response
    end

  end
  
end