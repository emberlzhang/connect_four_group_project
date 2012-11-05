require 'eventmachine'
require_relative './lib/game.rb'
require_relative './lib/ai.rb'
require_relative './lib/cvc.rb'
require_relative './lib/cvt.rb'
require_relative './lib/twitterplayer.rb'
require_relative './lib/twittermessenger.rb'

## Start listening

LISTEN_INTERVAL = 10 #seconds

EM.run do
  EM::PeriodicTimer.new(LISTEN_INTERVAL) do
    # Read Twitter search results for new challenges
    challenger = TwitterReader.challenger_name("Who wants to get demolished? #dbc_c4")
  end
end


challenger = nil
until challenger
	challenger = TwitterReader.challenger_name("")
end



p1 = AI.new
p2 = TwitterPlayer.new

cvt = ComputerVsTwitter.new(g.new, p1, p2, TwitterMessenger.new)

cvt.start

puts results.length
puts results.count(1)