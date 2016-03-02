This is a backend API. See http://www.sellarafaeli.com/blog/baas.html.

Tactical Ideas:
- in 'before' log the 'request' details to a 'requests' log. Also save the request id.
- in the 'after' add the result to the 'request' log.
- for every type/method add an 'after_hook', that is built out of: 'if [true || result[field] eq/gt/lt s.t. || get(something) eq/gt/lt s.t.] then [send_email || create_model || run_set_field_on_model]'
- blossom.io/app_name/api/users/123
- blossom.io/app_name/admin/data
- every app should have a 'fields' settings
  - by default the allowed_fields should be the fields 
  - by default the required_fields should be empty
  - by defaulat the unique_fields should be empty
- test everything....

Steps:
1. Create an API that works from a config file.
2. Create a mechanism to create that config file.
3. Create a mechanism to deploy a heroku app using said config file. 