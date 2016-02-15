require 'bundler'
Bundler.require
require './setup'

PUBLIC_USER_FIELDS = [:city,:one_liner,:public_email]

get '/' do
  erb :index
end
 
get '/users' do
  erb :users
end

get '/me' do
  erb :me
end

post '/me' do
  $users.update_one({_id: session[:user_id]},{"$set": params})
  erb :me
end

get '/signup' do
  erb :signup
end

post '/signup' do
  email = params[:email]  

  if $users.find(email: email).count > 0
    erb :index 
  else 
    id  = BSON::ObjectId.new.to_s    
    res = $users.insert_one(_id: id, email: email)
    session[:user_id] = id
    erb :index
  end
end

get '/signout' do
  session.clear
  erb :index
end

puts "SellasList is now running."