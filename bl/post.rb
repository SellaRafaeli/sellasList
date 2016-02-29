WHITE_FIELDS = ['user_id','username','email']

def post_fields(params, type = nil)
  coll       = $mongo.collection(type)  
  fields 
end

def update_item(params)
  white_fields = params.just(@allowed_fields)
  res          = @coll.update_id(params[:id],white_fields)
  {item: res}
end

post '/:coll/:id' do #update 
  @id = params[:id]
  update_item(params)
end

#TBD
# delete '/:coll/:id' do #delete 
#   get_coll_type
#   delete_item(params)
# end