require "twitter"
require "open-uri"
require "fileutils"


print 'ユーザー名:'
USERNAME = gets.chomp

client = Twitter::REST::Client.new do |config|
  config.consumer_key    = 'c2gbumfEcxZYlLN9kJqrqs8xe'
  config.consumer_secret = 'YAiOCLuxvMnpRanlQRV88wZ9FfOaTe9gb4UIdXDVHglJHRodp7'
  config.access_token    = '3071413153-FLG3HZDWACFXiSFVYpAQ6h7XJ3GqnYcRMcULNW0'
  config.access_token_secret = 'uuFqxyXrt4zaVGASnhEAOZkUsi2kMJJnDjIuNMyG6uKiz'
end



	max_id = client.user_timeline(USERNAME).first.id
	FileUtils.mkdir_p("./twitter-images/#{USERNAME}") unless FileTest.exist?("./twitter-images/#{USERNAME}")
	16.times do
		client.user_timeline(USERNAME, max_id: max_id, count: 200).each_with_index do |t, index|
			unless t.media.empty? then
				if (index != 0)  then
					t.media.map{|m| m.media_url.to_s}.each do |img_url|
						puts "#{USERNAME} image #{img_url} save to ./twitter-images/#{USERNAME}"
						tmp_path = "./twitter-images/#{USERNAME}/#{File.basename(img_url)}"
						File.open(tmp_path, 'w') do |f|
							f.write open(img_url).read
						end
					end
				end
			end
			max_id = t.id
		end
	end