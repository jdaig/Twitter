require 'nokogiri'
require 'open-uri'

class TwitterScrapper
  def initialize(url)
    @url = url
    @doc = Nokogiri::HTML(File.open(@url))
  end

  def extract_username
    profile_name = @doc.search('.ProfileHeaderCard-name > a')
    name = profile_name.first.inner_text
     "Username: #{name}"
  end

  def extract_tweets
    for i in 0...@doc.search(".TweetTextSize").count
      
      profile_name = @doc.search(".tweet-timestamp")[i]
      tiempo = profile_name.inner_text
      profile_name = @doc.search(".TweetTextSize")[i]
      tweet = profile_name.inner_text
      re_tweet = @doc.search(".js-actionRetweet").search(".ProfileTweet-actionCountForPresentation")[i*2].inner_text
      me_gusta = @doc.search(".js-actionFavorite").search(".ProfileTweet-actionCountForPresentation")[i*2].inner_text
      
      re_tweet = 0 if re_tweet == "" 
        
      me_gusta = 0 if me_gusta == ""

      puts "#{tiempo}: #{tweet}"
      puts "Retweets: #{re_tweet}, Me Gusta: #{me_gusta}"
      puts ""
    end

  end

  def extract_stats

    profile_name = @doc.search('.ProfileNav-stat > span')[0]
    var1 = profile_name.inner_text
    profile_name = @doc.search('.ProfileNav-stat > span')[1]
    var2 = profile_name.inner_text
    profile_name = @doc.search('.ProfileNav-stat > span')[2]
    var3 = profile_name.inner_text
    profile_name = @doc.search('.ProfileNav-stat > span')[3]
    var4 = profile_name.inner_text
    profile_name = @doc.search('.ProfileNav-stat > span')[4]
    var5 = profile_name.inner_text
    profile_name = @doc.search('.ProfileNav-stat > span')[5]
    var6 = profile_name.inner_text
    profile_name = @doc.search('.ProfileNav-stat > span')[6]
    var7 = profile_name.inner_text
    profile_name = @doc.search('.ProfileNav-stat > span')[7]
    var8 = profile_name.inner_text

     "Stats: #{var1}: #{var2}, #{var3}: #{var4}, #{var5}: #{var6}, #{var7}: #{var8}"
  end

end

url_new = ARGV
url_new = url_new[0]
html_file = open(url_new)
p html_file

test = TwitterScrapper.new(html_file)
system "clear"
puts "*" * 90
puts "*" * 90
puts test.extract_username
puts '-' * 90
puts "-" * 90
puts test.extract_stats
puts "-" * 90
puts "-" * 90
puts 'Tweets:'
test.extract_tweets
puts "*" * 90
puts "*" * 90