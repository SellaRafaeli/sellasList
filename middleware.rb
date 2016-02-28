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
  CONFIG[type.downcase.to_sym]
end

def missing_fields
  @config[:required_fields] - params.keys
end

def get_request_data
  @method       = request.env["REQUEST_METHOD"]
  @type         = request.path_info.split("/")[1]
  @config       = model_config(@type)[@method.downcase.to_sym]

  if @config
    @coll         = $mongo.collection(@type)
    halt(403, {msg: "Missing fields: #{missing_fields.join(",")}"}) if missing_fields
    x=1
  end
end