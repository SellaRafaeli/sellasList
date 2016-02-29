# usage: ruby spec/mobile_spec.rb prod 
puts "Running spec."
start = Time.now
env   = ARGV[0] 
cur_dir = File.expand_path(File.dirname(__FILE__))

require 'pry-byebug'
require "#{cur_dir}/lib_spec.rb"
require 'faker'
require 'colorize'

puts "Loaded colorize. Hope for the best.".green
NEW_USERNAME_1   = Faker::Name.name
EXISTING_USER_ID = 'users_56d412709ece07c69b000003'

tests = {
#  :ping => [GET, '/ping', {}],
  :create_user => [POST, '/users', {_method: 'put', name: Faker::Name.name, email: Faker::Internet.email, username: NEW_USERNAME_1}],
  :get_existing_user => [GET, "/users/#{EXISTING_USER_ID}", {}],
}

def mobile_expected_results(idx, res)
  success = case idx
  when :ping         
    res['pong'] == true
  when :create_user  
    puts res  
    res['success'] == true && res['new_obj']['username'] == NEW_USERNAME_1
  when :get_existing_user
    res['items'][0]['_id'] == EXISTING_USER_ID
  else
    puts "No expectation function defined for idx #{idx}".yellow
    false
  end
rescue => e 
end

test_cases = tests.keys
test_cases = Array(test_cases)

opts = {}
test_cases.each do |idx| 
  test_response(tests, idx, :mobile_expected_results, opts)
end
puts "took #{Time.now-start} seconds."