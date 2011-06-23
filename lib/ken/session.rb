module Ken
  class << self
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
  
  class AttributeNotFound < StandardError ; end
  class PropertyNotFound < StandardError ; end
  class ResourceNotFound < StandardError ; end
  class TopicNotFound < StandardError ; end
  class ViewNotFound < StandardError ; end
  
  # partially taken from chris eppstein's freebase api
  # http://github.com/chriseppstein/freebase/tree
  class Session
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
      :blurb => '/api/trans/blurb',
      :raw => '/api/trans/raw',
      :login => '/api/account/login',
      :upload => '/api/service/upload',
      :topic => '/experimental/topic',
      :search => '/api/service/search'
    }

    # get the service url for the specified service.
    def service_url(svc)
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

    # Perform a mqlread and return the results
    # Specify :cursor => true to batch the results of a query, sending multiple requests if necessary.
    # TODO: should support multiple queries
    #       you should be able to pass an array of queries
    def mqlread(query, options = {})
      Ken.logger.info ">>> Sending Query: #{query.to_json}"
      cursor = options[:cursor]
      if cursor
        query_result = []
        while cursor
          response = get_query_response(query, cursor)
          query_result += response['result']
          cursor = response['cursor']
        end
      else
        response = get_query_response(query, cursor)
        cursor = response['cursor']
        query_result = response['result']
      end
      query_result
    end
    
    def raw_content(id, options = {})
      response = http_request raw_service_url+id, options
      Ken.logger.info "<<< Received Raw Content Response: #{response}"
      response
    end
    
    def blurb_content(id, options = {})
      response = http_request blurb_service_url+id, options
      Ken.logger.info "<<< Received Blurb Content Response: #{response}"
      response
    end
    
    def topic(id, options = {})
      options.merge!({:id => id})
      
      response = http_request topic_service_url+"/standard", options
      result = JSON.parse response
      inner = result[id]
      handle_read_error(inner)
      Ken.logger.info "<<< Received Topic Response: #{inner['result'].inspect}"
      inner['result']
    end
    
    def search(query, options = {})
      Ken.logger.info ">>> Sending Search Query: #{query.to_json}"
      options.merge!({:query => query})
      
      response = http_request search_service_url+"/standard", options
      result = JSON.parse response
      inner = result['result']
      handle_read_error(inner)
      Ken.logger.info "<<< Received Topic Response: #{inner['result'].inspect}"
      inner
    end

    protected
    # returns parsed json response from freebase mqlread service
    def get_query_response(query, cursor=nil)
      envelope = { :qname => {:query => query, :escape => false }}
      envelope[:qname][:cursor] = cursor if cursor
      
      response = http_request mqlread_service_url, :queries => envelope.to_json
      result = JSON.parse response
      inner = result['qname']
      handle_read_error(inner)
      Ken.logger.info "<<< Received Response: #{inner['result'].inspect}"
      inner
    end
    
    # encode parameters
    def params_to_string(parameters)
      parameters.keys.map {|k| "#{URI.encode(k.to_s)}=#{URI.encode(parameters[k].to_s)}" }.join('&')
    end
    
    # does the dirty work
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