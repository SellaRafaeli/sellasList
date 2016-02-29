WHITE_FIELDS = ['user_id','username','email']

def format_obj(obj, type = nil)
  case type.to_sym
  when :users then obj.just('_id', 'username')
  when :posts then obj.just('slug')
  else obj
  end
end

def post_fields(params, type = nil)
  coll       = $mongo.collection(type)  
  fields 
end

def post_item(params)
  coll, fields, opts = post_fields(params, type)
  coll.update_one(crit,fields)
end

post '/:coll/:id' do #update 
  update_item(params)
end

#TBD
# delete '/:coll/:id' do #delete 
#   get_coll_type
#   delete_item(params)
# end