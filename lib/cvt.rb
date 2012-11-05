class ComputerVsTwitter
  attr_reader :game, :p1, :p2
  def initialize(game, p1, p2, messenger)
    @game = game
    @p1 = p1 #AI -- computer
    @p2 = p2 #twitter
  end

  def start
    until game.over?
      new_move = p1.get_move
      game.make_move(new_move)

      messenger.send_move(new_move)

      # puts "Player 1: #{new_move}"
      # game.display_board

      break if game.over?

      new_move = p2.get_move
      game.make_move(new_move)
      p1.set_move(new_move)

      # puts "Player 2: #{new_move}"
      # game.display_board
    end
  end #start
end #ComputerVsTwitter
