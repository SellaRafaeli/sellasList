$app_name = 'backend_api'

enable :sessions

def bp
  binding.pry
end

DB_URI = ENV["MONGOLAB_URI"] || "mongodb://localhost:27017/#{$app_name}"

$mongo = Mongo::Client.new(DB_URI).database
$users = $mongo.collection('users')
$posts = $mongo.collection('posts')