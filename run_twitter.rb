require 'pry'
require 'eventmachine'
require_relative './lib/game.rb'
require_relative './lib/ai.rb'
require_relative './lib/cvt.rb'
require_relative './lib/twitterplayer.rb'
require_relative './lib/twittermessenger.rb'

# Start listening

TWITTER_NAME = "HAL_C4"
LISTEN_INTERVAL    = 5 #seconds
BROADCAST_INTERVAL = 1 #seconds

def listen_for_challenges
  EM.run do
    EM::PeriodicTimer.new(LISTEN_INTERVAL) do
      challenger = TwitterReader.challenger_name("Who wants to get demolished? #dbc_c4")
      accept_challenge(challenger)
      start_game_as_p2(challenger) if challenger_name
    end
  end
end


def accept_challenge(challenger)
  TwitterReader.broadcast("to:#{challenger} Game on! #dbc_c4")
end

def start_game_as_p2(challenger)
  p1 = AI.new
  p2 = TwitterPlayer.new
  cvt = ComputerVsTwitter.new(g.new, p1, p2,challenger)
  cvt.start
end

def start_game_as_p1(challenger)
  p2 = AI.new
  p1 = TwitterPlayer.new
  cvt = ComputerVsTwitter.new(ConnectFour.new, p1, p2,challenger)
  cvt.start
end


def broadcast_challenge
  TwitterReader.broadcast("Who wants to get demolished? #dbc_c4")
  listen_for_challenge_acceptance
end

def listen_for_challenge_acceptance
  EM.run do
    EM::PeriodicTimer.new(LISTEN_INTERVAL) do
      challenger = TwitterReader.challenger_name("Game on! #dbc_c4",TWITTER_NAME)
      start_game_as_p1(challenger) if challenger
    end
  end
end


# cvt = ComputerVsTwitter.new(g.new, p1, p2)
# cvt.start

# puts cvc.game.utility

binding.pry