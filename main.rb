# configs

require 'bundler/inline'
require 'json'

gemfile do
  source 'https://rubygems.org'

  gem 'pry'
  gem 'httparty'
end

# SWAPI Obi-Wan setup, has ID=10
SWAPI_URL = 'https://swapi.dev/api'
OBI_WAN = SWAPI_URL + '/people/10'

# get Obi-Wan data from swapi via long url
obi_wan_response = HTTParty.get(OBI_WAN)
obi_wan_hash = JSON.parse(obi_wan_response.body)

# Bitlink request setup 
BIT_LINK_API_URL = 'https://api-ssl.bitly.com/v4'
SHORTEN_ENDPOINT = BIT_LINK_API_URL + "/shorten"

ACCESS_TOKEN = 'YOUR_TOKEN_HERE'
HEADERS = { 'Authorization': "Bearer #{ACCESS_TOKEN}", 'Content-Type': 'application/json', }

# bit_link shorten obi_wan url
payload = JSON.dump({ 'long_url' => OBI_WAN })
bitly_shorten = HTTParty.post(SHORTEN_ENDPOINT, headers: HEADERS, body: payload)

obi_wan_shorten_link = JSON.parse(bitly_shorten.body)['link']

# get Obi-Wan data via bit_link shorten url
obi_wan_response_bitlink = HTTParty.get(obi_wan_shorten_link)
obi_wan_bitlink_hash = JSON.parse(obi_wan_response_bitlink.body)

# compare result
p obi_wan_hash == obi_wan_bitlink_hash
