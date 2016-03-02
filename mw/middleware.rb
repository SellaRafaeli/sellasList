before do   
  @foo = :bar
  @time_started = Time.now  
  get_request_data  
end

after do 
  if @response.body.is_a? Hash #return hashes as json
    @response.body[:time] = Time.now - @time_started rescue nil
    content_type 'application/json'
    @response.body = @response.body.to_json   
  end 
end

def model_config(type)
  CONFIG[type.to_s.downcase.to_sym]
end

def get_request_data
  @method       = request.env["REQUEST_METHOD"].downcase.to_sym
  @type         = request.path_info.split("/")[2]
  if model_config(@type)
    @config = model_config(@type)
    @method_config   = @config[@method] || {}    
    @coll            = $mongo.collection(@type)

    @fields          = @method_config[:fields]         || @config[:fields]          || []
    
    @allowed_fields = @method_config[:allowed_fields] || @config[:allowed_fields]  || @fields
    @required_fields = @method_config[:required_fields]|| @config[:required_fields] || []    
    @unique_fields   = @method_config[:unique_fields]  || @config[:unique_fields]   || []
    missing_fields   = @required_fields - params.keys
    halt_missing_fields(missing_fields) if missing_fields.any?        

    if @method == :get
      @allowed_fields += [:mongo_crit_json]
    end    

    @af = @allowed_fields #debug helper
  end
end

def format_obj(obj, type = nil)
  case type.to_sym
  when :users then obj.just('_id', 'username')
  else obj
  end
end
