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
OTHER_USERNAME   = Faker::Name.name
tests = {
#  :ping => [GET, '/ping', {}],
  :create_user => [PUT, '/users', {_method: 'put', name: Faker::Name.name, email: Faker::Internet.email, username: NEW_USERNAME_1}],
  :get_existing_user => [GET, "/users/#{EXISTING_USER_ID}", {}],
  :update_user => [POST, "/users/#{EXISTING_USER_ID}",{username: OTHER_USERNAME}]
}

def expected_results(idx, res)
  success = case idx
  when :ping         
    res['pong'] == true
  when :create_user  
    puts res  
    res['item']['username'] == NEW_USERNAME_1
  when :get_existing_user
    res['items'][0]['_id'] == EXISTING_USER_ID
  when :update_user
    res['item']['username'] == OTHER_USERNAME
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
  test_response(tests, idx, :expected_results, opts)
end
puts "took #{Time.now-start} seconds."