puts "starting app..."

require 'bundler'
require 'active_support/core_ext'
require 'sinatra/reloader' #dev-only

puts "requiring gems..."
Bundler.require

require './setup'
require './users'
require './my_lib'

require_all './db'
require_all './mw'
require_all './bl'

get '/ping' do
  {msg: '123 pong from BEAPI', pong: true}
end

require_all './apis'

CONFIG = {
  users: {
    fields: ['name','email','age','username'],
    allowed_fields: ['name','email','age','username'],      
    unique_fields: ['email'],      
    put: {
      required_fields: ['name','email','username'],
    },
    get: {
    }      
  },

  posts: {  
    fields: ['user_id','text'],
    put: {
      required_fields: ['user_id','text']
    }
  }
}

