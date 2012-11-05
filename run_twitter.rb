require 'eventmachine'
require_relative './lib/game.rb'
require_relative './lib/ai.rb'
require_relative './lib/cvt.rb'
# require_relative './lib/twitterplayer.rb'
# require_relative './lib/twittermessenger.rb'

# Start listening

LISTEN_INTERVAL    = 10 #seconds
BROADCAST_INTERVAL = 10 #seconds

def listen_for_challenges
  EM::PeriodicTimer.new(LISTEN_INTERVAL) do
    challenger = TwitterReader.challenger_name("Who wants to get demolished? #dbc_c4")
    start_game_as_p2(challenger) if challenger
  end
end


def start_game_as_p2(challenger)
  p1 = AI.new
  p2 = TwitterPlayer.new(challenger)
  cvt = ComputerVsTwitter.new(g.new, p1, p2)
  cvt.start
end

def start_game_as_p1(challenger)
  p2 = AI.new
  p1 = TwitterPlayer.new(challenger)
  cvt = ComputerVsTwitter.new(g.new, p1, p2)
  cvt.start
end


def broadcast_challenge
  EM::PeriodicTimer.new(BROADCAST_INTERVAL) do
    TwitterReader.broadcast("Who wants to get demolished? #dbc_c4")
    listen_for_challenge_acceptance
  end
end

def listen_for_challenge_acceptance
  challenger = TwitterReader.challenger_name("Who wants to get demolished? #dbc_c4")
    start_game_as_p1(challenger) if challenger
end


# cvt = ComputerVsTwitter.new(g.new, p1, p2)
# cvt.start

# puts cvc.game.utility