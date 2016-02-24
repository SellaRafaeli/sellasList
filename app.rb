require 'bundler'
Bundler.require
require './setup'
require './users'

puts "BackendAPI is now running."

after do 
  if @response.body.is_a? Hash #return hashes as json
    content_type 'application/json'
    @response.body = @response.body.to_json   
  end
end