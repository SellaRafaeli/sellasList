def ensure_unique
  @unique_fields.each do |field| 
    val = params[field]
    halt_item_exists(field, val) if get_single_item(field => val)    
  end
end

def create_item(params)   
  ensure_unique

  white_params      = params.just(@allowed_fields)
  
  new_obj           = @coll.add(white_params)
  
  formatted_new_obj = format_obj(new_obj, @type)
  
  {success: true, new_obj: formatted_new_obj}
rescue => e
  halt_error(e.to_s)
end

#CRUD
# curl -d _method=put -d name="joe cohen" -d username=time34221 -d email="joe4@cohen22231.net" localhost:9393/users
put '/:coll' do #create
  create_item(params)
end