require 'eventmachine'
require_relative './lib/game.rb'
require_relative './lib/ai.rb'
require_relative './lib/cvc.rb'
# require_relative './lib/cvt.rb'
# require_relative './lib/twitterplayer.rb'
# require_relative './lib/twittermessenger.rb'

## Start listening

# LISTEN_INTERVAL = 10 #seconds

# EM.run do
#   EM::PeriodicTimer.new(LISTEN_INTERVAL) do
#     # Read Twitter search results for new challenges
#     challenger = TwitterReader.challenger_name("Who wants to get demolished? #dbc_c4")
#   end
# end


# challenger = nil
# until challenger
# 	challenger = TwitterReader.challenger_name("")
# end



p1 = AI.new
p2 = Twitter.new
g = ConnectFour

cvc = ComputerVsComputer.new(g.new, p1, p2)

results = []
500.times do
  cvc.start
  results << cvc.game.utility
end

# puts cvc.game.utility
puts results.count(1)