require 'unirest'

response = Unirest.get("")

puts JSON.pretty_generate(response.body)