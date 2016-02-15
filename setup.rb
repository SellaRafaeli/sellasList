enable :sessions

def bp
  binding.pry
end

#db
DB_URI = ENV["MONGOLAB_URI"] || "mongodb://localhost:27017/sellas-list"

$mongo = Mongo::Client.new(DB_URI).database
$users = $mongo.collection('users')