module Ken
  class << self #:nodoc:
    attr_accessor :session
  end
  
  # A class for returing errors from the freebase api.
  # For more infomation see the freebase documentation:
  class ReadError < ArgumentError
    attr_accessor :code, :msg
    def initialize(code,msg)
      self.code = code
      self.msg = msg
    end
    def message
      "#{code}: #{msg}"
    end
  end
  
  # partially taken from chris eppstein's freebase api
  # http://github.com/chriseppstein/freebase/tree
  class Session
    # include Singleton
    
    public
    # Initialize a new Ken Session
    #   Ken::Session.new(host{String, IO}, username{String}, password{String})
    #
    # @param host<String>          the API host
    # @param username<String>      freebase username
    # @param password<String>      user password
    def initialize(host, username, password)
      @host = host
      @username = username
      @password = password
      
      Ken.session = self

      # TODO: check connection
      Ken.logger.info("connection established.")
    end
    
    SERVICES = {
      :mqlread => '/api/service/mqlread',
      :mqlwrite => '/api/service/mqlwrite',
      :login => '/api/account/login',
      :upload => '/api/service/upload'
    }

    # get the service url for the specified service.
    def service_url(svc)
      #"http://#{Configuration.instance[:host]}#{SERVICES[svc]}"
      "#{@host}#{SERVICES[svc]}"
    end

    SERVICES.each_key do |k|
      define_method("#{k}_service_url") do
        service_url(k)
      end
    end

    # raise an error if the inner response envelope is encoded as an error
    def handle_read_error(inner)
      unless inner['code'][0, '/api/status/ok'.length] == '/api/status/ok'
        Ken.logger.error "Read Error #{inner.inspect}"
        error = inner['messages'][0]
        raise ReadError.new(error['code'], error['message'])
      end
    end # handle_read_error

    # perform a mqlread and return the results
    # TODO: should support multiple queries
    #       you should be able to pass an array of queries
    def mqlread(query, options = {})
      Ken.logger.info ">>> Sending Query: #{query.to_json}"
      
      envelope = { :qname => {:query => query }}
      
      response = http_request mqlread_service_url, :queries => envelope.to_json
      result = JSON.parse response
      inner = result['qname']
      handle_read_error(inner)
      
      Ken.logger.info "<<< Received Response: #{inner['result'].inspect}"
      
      # will always return the converted ruby hash (from json)
      inner['result']
    end # mqlread

    protected
    def params_to_string(parameters)
      parameters.keys.map {|k| "#{URI.encode(k.to_s)}=#{URI.encode(parameters[k])}" }.join('&')
    end

    def http_request(url, parameters = {})
      params = params_to_string(parameters)
      url << '?'+params unless params !~ /\S/

      return Net::HTTP.get_response(::URI.parse(url)).body
      
      fname = "#{MD5.md5(params)}.mql"
      open(fname,"w") do |f|
        f << response
      end
      Ken.logger.info("Wrote response to #{fname}")
    end
    
  end # class Session
end # module Ken