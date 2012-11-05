require 'twitter'
require_relative './credentializer.rb'

class TwitterReader
	attr_reader :client, :credentials

  MAX_CACHE = 50

  def self.challenger_name(msg,name=nil)
    result = client.search(msg).results.first.attrs
    to_name, from_name = result[:entities][:user_mentions].first[:screen_name], result[:user][:name]

    if name == to_name
      return from_name
    else
      nil
    end
  end

  def self.broadcast(msg)
    client.update("#{msg} ##{uniquekey}")
  end

  def self.client
    @client ||= client_with_authentication
  end

  def client
    @client ||= client_with_authentication
  end

  def get_move(twitter_user_name)
    # a string of the form: "@username blablabla |.......|.......|.......|.......|...XO..|..XOX..| #uniquekey #dbc_c4"
    client.search("to:#{twitter_user_name} #dbc_c4",:result_type=>"recent").results.first.text
  end

  def send_move(twitter_user_name,board)
    client.update("@#{twitter_user_name} #{board} #dbc_c4 ##{uniquekey}")
  end

  def self.uniquekey
    (('a'..'z').to_a + ('A'..'Z').to_a + (1..9).to_a).shuffle[0..2].join
  end

  def uniquekey
    self.class.uniquekey
  end

	private
  def self.client_with_authentication
    credentials = Credentializer.twitter_credentials
    new_client = Twitter::Client.new
    new_client.configure do |config|
      config.consumer_key       = credentials[:consumer_key]
      config.consumer_secret    = credentials[:consumer_secret]
      config.oauth_token        = credentials[:oauth_token]
      config.oauth_token_secret = credentials[:oauth_token_secret]
    end
    return new_client
  end

  def client_with_authentication
    self.class.client_with_authentication
  end
end #TwitterReader
