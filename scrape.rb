# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

# スクレイピング先のURL
# 検索タグ
SEARCHTAG = '岸和田'

# 取得対象ページ
url = 'https://www.instagram.com/explore/tags/' + URI.encode_www_form_component(SEARCHTAG) + '/?__a=1'
charset = nil

html = open(url) do |f|
  charset = f.charset # 文字種別を取得
  f.read # htmlを読み込んで変数htmlに渡す
end

# htmlをパース(解析)してオブジェクトを生成
 allDoc = Nokogiri::HTML.parse(html, nil, charset)
  # メタ情報だけ取得
  metaInfo = allDoc.css('script')[6].text
  # 前後に不要な情報があるのでカット
  metaInfo.slice!(0, 21)
  metaInfo = metaInfo.chop
  metaInfo = JSON.load(metaInfo)


p metaInfo