$app_name = 'backend_api'

$root_url   = $prod ? $prod_url : 'http://localhost:9393'

enable :sessions

def bp
  binding.pry
end

def get_fullpath
  $root_url + request.fullpath
end