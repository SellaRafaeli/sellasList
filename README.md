This is a backend API.

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

Strategic Ideas: 
- The idea is make the process of creating an API / BE / Server as easy as possible.
- Monetization options:
  1. Host their backend
  2. Spin it off as a separate Heroku instance, give them control. 
     - this can be done even if hosting; will allow for separate CPU / DB, s.t. one request does not throttle the others
     - this might make it impossible / harder to introduce code changes to affect everyone 
  3. Let humans (non-devs) build it.
  4. Open-Source it

1. Open-Source it.
2. Host it.
3. Deliver it as a product. 
4. Let humans build it for you. 