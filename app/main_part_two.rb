require 'yaml'
require 'twitter'
require 'nokogiri'

require_relative 'models/CongressMember'
require_relative 'models/Tweet'

# Load Twitter OAuth Settings
twitter_settings = YAML.load_file('app/twitter.yml')["development"]
client = Twitter::REST::Client.new do |config|
    config.consumer_key        = twitter_settings["consumer_key"]
    config.consumer_secret     = twitter_settings["consumer_secret"]
    config.access_token        = twitter_settings["access_token"]
    config.access_token_secret = twitter_settings["access_token_secret"]
end

# Crawl Tweets
puts "Please enter a congress member id: "
cm_id = gets.chomp
member = CongressMember.find(cm_id.to_i)
raise "Error: Unable to find user." if member.nil?
raise "Error: This user has no twitter id." if member.twitter_id.nil?
client.user_timeline(member.twitter_id).take(10).collect do |tweet|
    begin
        insert = member.tweets.create!(
            :tweet_id => tweet.id,
            :tweet_text => Nokogiri.HTML(tweet.text).text
        )
        puts "#{member.firstname}: #{insert.tweet_text}"
    rescue
        puts "Tweet id: #{tweet.id} already exists."
    end
end
