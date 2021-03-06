def stop_if_exists_by(fields)
  fields.each do |field| 
    val = params[field]
    halt_item_exists(field, val) if get_single_item(field => val)    
  end
end

def create_item(params)   
  stop_if_exists_by(@unique_fields)

  white_fields   = params.just(@allowed_fields)
  
  new_item          = @coll.add(white_fields)
  
  formatted_item    = format_obj(new_item, @type)
  
  {item: formatted_item}
rescue => e
  halt_error(e.to_s)
end

#CRUD
# curl -d _method=put -d name="joe cohen" -d username=time34221 -d email="joe4@cohen22231.net" localhost:9393/users
put '/api/:coll' do #create
  create_item(params)
end