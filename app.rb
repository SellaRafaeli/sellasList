require 'bundler'
require 'active_support/core_ext'
Bundler.require
require './setup'
require './users'
require './my_lib'
require './mongo'
require './middleware'

get '/ping' do
  {msg: 'pong from BEAPI'}
end

WHITE_FIELDS = ['user_id','username','email']

def format_obj(obj, type = nil)
  case type.to_sym
  when :users then obj.just('username')
  when :posts then obj.just('slug')
  end
end

def get_crit(params, type = nil)
  return {_id: params[:id]} if params[:id]

  case type.to_sym
  when :users then params.just(WHITE_FIELDS)
  when :posts then {num_likes: {"$gt": 10}}
  end
end

def get_mongo_data(params, type)
  crit       = get_crit(params, type)
  coll       = $mongo.collection(type)  
  sort       = params[:sort]
  sort_dir   = params[:sort_dir] || 1
  limit      = params[:limit]    || 5
  skip       = params[:skip]     || 0

  opts       = {limit: limit.to_i, skip: skip.to_i}
  opts[:sort]= [{sort => sort_dir.to_i}] if sort

  return coll, crit, opts
end

get '/:coll/?:id?' do   
  type             = params[:coll]
  coll, crit, opts = get_mongo_data(params, type)  
  items, done      = page_mongo(coll, crit, opts)
  formatted_items  = items.map {|i| format_obj(i, type)}
  {data: formatted_items, done: done}
end

post '/:coll/:id' do 
  {wip: true}
end

puts "BackendAPI is now running."