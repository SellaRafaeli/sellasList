def add_crit(crit,k,v)
  if k.to_sym == :mongo_crit_json
    crit.merge!(JSON.parse(v))
  else 
    crit[k] = v
  end
end

def get_crit(params, type = nil)
  return {_id: params[:id]} if params[:id]
  crit = {}
  params.just(@allowed_fields).each { |k,v| add_crit(crit,k,v) }
  crit
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

def get_items(params)
  type             = @type
  coll, crit, opts = get_mongo_data(params, type)  
  items, done      = page_mongo(coll, crit, opts)
  formatted_items  = items.map {|i| format_obj(i, type)}
  {items: formatted_items, done: done}
end

def get_single_item(params)
  (get_items(params)[:items] || []).first
end

# 
get '/api/:coll/?:id?' do #read 
  get_items(params)
end
