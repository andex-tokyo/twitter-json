require 'json'
require 'uri'
require 'net/http'
require "open-uri"
require "FileUtils"

def save_image(url)
  # ready filepath
  fileName = File.basename(url)
  dirName = "./img/"
  filePath = dirName + fileName

  # create folder if not exist
  FileUtils.mkdir_p(dirName) unless FileTest.exist?(dirName)

  # write image data
  open(filePath, 'wb') do |output|
    open(url) do |pic|
      output.write(pic.read)
    end
  end
end

# 検索タグ
print 'ユーザー名:'
USERNAME = gets.chomp

# 取得対象ページ
feedurl = 'https://www.instagram.com/' + URI.encode_www_form_component(USERNAME) + '/?__a=1'

puts USERNAME + " のデータを取得します"

uri = URI.parse(feedurl)
json = Net::HTTP.get(uri)
result = JSON.parse(json)
hash = result["user"]["media"]["nodes"]
hash.each do |data|
     url = data["thumbnail_src"]  
    url[/\?\S+/] = ""
   save_image(url)
end

p "完了しました。"