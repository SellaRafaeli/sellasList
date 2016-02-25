$app_name = 'backend_api'
$app_name = 'yesno_prod_backup'

$root_url   = $prod ? $prod_url : 'http://localhost:9393'

enable :sessions

def bp
  binding.pry
end

def get_fullpath
  $root_url + request.fullpath
end