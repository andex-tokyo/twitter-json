require 'json'
require 'uri'
require 'net/http'

# 検索タグ
print 'ユーザー名:'
USERNAME = gets.chomp

# 取得対象ページ
url = 'https://www.instagram.com/' + URI.encode_www_form_component(USERNAME) + '/?__a=1'

puts USERNAME + " のデータを取得します"

uri = URI.parse(url)
json = Net::HTTP.get(uri)
result = JSON.parse(json)
hash = result["user"]["media"]["nodes"]
hash.each do |data|
     imgurl = data["thumbnail_src"]  
    puts imgurl
end