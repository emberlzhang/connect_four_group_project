require_relative './lib/game.rb'
require_relative './lib/ai.rb'
require_relative './lib/cvc.rb'

p1 = AI.new
p2 = AI.new
g = ConnectFour

cvc = ComputerVsComputer.new(g.new, p1, p2)

cvc.start

puts "Winning player #{cvc.game.utility}"