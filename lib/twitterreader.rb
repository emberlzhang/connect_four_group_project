require 'twitter'
require_relative './credentializer.rb'

class TwitterReader
	include Credentializer
	attr_reader :client, :credentials

	def initialize
		@credentials = twitter_credentials(self)
		@client = client_with_authentication
	end

  def get_move(twitter_user_name, unique_key)
    # a string of the form: "@username blablabla |.......|.......|.......|.......|...XO..|..XOX..| #uniquekey #dbc_c4"
    client.search("to:#{twitter_user_name} '#'#{unique_key} #dbc_c4",:result_type=>"recent").results.first.text
  end

	private
  def client_with_authentication
    new_client = Twitter::Client.new
    new_client.configure do |config|
      config.consumer_key       = credentials[:consumer_key]
      config.consumer_secret    = credentials[:consumer_secret]
      config.oauth_token        = credentials[:oauth_token]
      config.oauth_token_secret = credentials[:oauth_token_secret]
    end
    return new_client
	end #TwitterReader
