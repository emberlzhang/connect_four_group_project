require 'rjb'

class AI
  # This AI keeps an internal representation of the connect4 board
  def initialize
    Rjb::load(File.dirname(__FILE__) + "/con41.6.jar", jvmargs = [""])
    @ai = Rjb::import('ConnectFour').new
  end

  def get_move
    @ai.bestmove
  end

  def set_move(col)
    @ai.play(col)
  end


end
