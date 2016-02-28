require 'bundler'
require 'active_support/core_ext'
Bundler.require
require './setup'
require './users'
require './my_lib'
require './middleware'

require_all './db'
require_all './bl'


get '/ping' do
  {msg: 'pong from BEAPI'}
end

puts "BackendAPI is now running."