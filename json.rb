require "json"
require "net/http"
require "open-uri"
require "FileUtils"
require "csv"


def get_imageurl(feedurl)
    uri = URI.parse(feedurl)
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    hash = result["user"]["media"]["nodes"]
    hash.each do |data|
        url = data["thumbnail_src"]  
        url[/\?\S+/] = ""
        cap = data["caption"]
        save_image(url)
        filepath=File.basename(url)
        CSV.open("./#{USERNAME}.csv", "a") do |csv|
            csv << [filepath, cap]
        end
    end
end


def save_image(url)
  # ready filepath
  fileName = USERNAME+"_"+File.basename(url)
    dirName = "./img_#{USERNAME}/"
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



print 'ユーザー名:'
USERNAME = gets.chomp
feedurl = 'https://www.instagram.com/' + URI.encode_www_form_component(USERNAME) + '/?__a=1'
puts USERNAME + " データを取得します"
get_imageurl(feedurl)
p "完了しました。"


