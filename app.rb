puts "starting app..."

require 'bundler'
#require 'active_support/core_ext'

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

post '/test' do
  {params: params}
end

require_all './bl'

CONFIG = {
  users: {
      name: :users,
      put: {
        allowed_fields: ['name','email','age','username'],
        required_fields: ['name','email'],
        unique_fields: ['email']
      },
      get: {
        allowed_fields: ['email','foo'],
      }
    },
  get: {

  },
  posts: {

    },
  comments: {

  }
}