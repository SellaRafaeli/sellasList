before do 
  @time_started = Time.now
end

after do 
  if @response.body.is_a? Hash #return hashes as json
    @response.body[:time] = Time.now - @time_started
    content_type 'application/json'
    @response.body = @response.body.to_json   
  end 
end