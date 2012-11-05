class ComputerVsComputer
  attr_reader :game, :p1, :p2
  def initialize(game, p1, p2)
    @game = game
    @p1 = p1
    @p2 = p2
  end

  def start
    until game.over?
      new_move = p1.get_move
      game.make_move(new_move)

      puts "Player 1: #{new_move}"
      puts game.display_board

      break if game.over?

      p2.set_move(new_move)

      new_move = p2.get_move
      game.make_move(new_move)
      p1.set_move(new_move)

      puts "Player 2: #{new_move}"
      puts game.display_board
    end
  end #start
end #ComputerVsComputer
