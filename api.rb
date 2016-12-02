require 'twitter'

print 'ユーザー名:'
USERNAME = gets.chomp

@client = Twitter::REST::Client.new do |config|
  config.consumer_key    = 'c2gbumfEcxZYlLN9kJqrqs8xe'
  config.consumer_secret = 'YAiOCLuxvMnpRanlQRV88wZ9FfOaTe9gb4UIdXDVHglJHRodp7'
  config.access_token    = '3071413153-FLG3HZDWACFXiSFVYpAQ6h7XJ3GqnYcRMcULNW0'
  config.access_token_secret = 'uuFqxyXrt4zaVGASnhEAOZkUsi2kMJJnDjIuNMyG6uKiz'
end

@client.user_timeline(USERNAME, { count: 2 } ).each do |timeline|
  puts @client.status(timeline).text
end
