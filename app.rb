puts "starting app..."

require 'bundler'
require 'active_support/core_ext'

puts "requiring gems..."
Bundler.require

require './setup'
require './users'
require './my_lib'

require_all './db'
require_all './mw'

get '/ping' do
  {msg: 'pong from BEAPI', pong: true}
end

require_all './bl'

CONFIG = {
  users: {
      name: :users,
      fields: ['name','email','age','username'],
      allowed_fields: ['name','email','age','username'],      
      unique_fields: ['email'],
      
      put: {
        required_fields: ['name','email','username'],
      },
      get: {
      }
      
    },
  comments: {

  }
}

