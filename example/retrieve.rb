require 'opensrf'

# method = 'open-ils.search.config.copy_status.retrieve.all'
method = 'open-ils.search.biblio.record.mods_slim.retrieve'
service = 'open-ils.search'
params = [1]
host = 'evergreen.owwl.org'

o = Opensrf::Request.new host
o.set_service service
o.set_message method, params

response = o.send

puts
puts 'RESPONSE FROM:'
puts response.from
puts 'RESPONSE THREAD:'
puts response.thread
puts 'RESPONSE KEYS:'
puts response.parsed.keys
puts 'RESPONSE STATUS:'
puts response['status']['status_code']
puts 'RESPONSE RESULT:'
puts response['result']['content']