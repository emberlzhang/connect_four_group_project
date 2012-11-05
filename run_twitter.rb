require 'eventmachine'
require_relative './lib/game.rb'
require_relative './lib/ai.rb'
require_relative './lib/cvt.rb'
# require_relative './lib/twitterplayer.rb'
# require_relative './lib/twittermessenger.rb'

# Start listening

LISTEN_INTERVAL = 10 #seconds

EM.run do
  EM::PeriodicTimer.new(LISTEN_INTERVAL) do
    # Read Twitter search results for new challenges
    challenger = TwitterReader.challenger_name("Who wants to get demolished? #dbc_c4")
  end
end



# p1 = AI.new
# p2 = TwitterPlayer.new(name,unique_key)
g = ConnectFour

# cvt = ComputerVsTwitter.new(g.new, p1, p2)
# cvt.start

puts cvc.game.utility