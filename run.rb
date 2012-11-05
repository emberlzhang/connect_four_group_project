require_relative './lib/game.rb'
require_relative './lib/ai.rb'
require_relative './lib/cvc.rb'
require_relative './lib/cvt.rb'
require_relative './lib/twitterplayer.rb'
require_relative './lib/twittermessenger.rb'

p1 = AI.new
p2 = TwitterPlayer.new

cvt = ComputerVsTwitter.new(g.new, p1, p2, TwitterMessenger.new)

cvt.start

puts results.length
puts results.count(1)