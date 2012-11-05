class ComputerVsTwitter
  attr_reader :game, :p1, :p2
  def initialize(game, p1, p2, messenger)
    @game = game
    @p1   = p1 #AI -- computer
    @p2   = p2 #twitter
  end


  def start
    case
    when p1.instance_of?(AI)             then start_p1
    when p1.instance_of?(TwitterPlayer)  then start_p2
    end
  end


  # Start a Computer v. Twitter game as player1
  def start_p1
    until game.over?
      new_move = p1.get_move
      game.make_move(new_move)

      board = move_to_board(new_move)
      messenger.send_move(board) #send move to Twitter

      # puts "Player 1: #{new_move}"
      # game.display_board

      break if game.over?

      new_move = p2.get_move
      game.make_move(new_move)
      p1.set_move(new_move) #send the move to the AI

      # puts "Player 2: #{new_move}"
      # game.display_board
    end
  end #start_p1

  def start_p2
    until game.over?
      new_move = p1.get_move
      game.make_move(new_move)

      p2.set_move(new_move) #send the move to the AI

      # puts "Player 1: #{new_move}"
      # game.display_board

      break if game.over?

      new_move = p2.get_move
      game.make_move(new_move)

      board = move_to_board(new_move)
      messenger.send_move(board) #send move to Twitter

      # puts "Player 2: #{new_move}"
      # game.display_board
    end
  end #start_p1

  def move_to_board
    game.display_board
  end
end #ComputerVsTwitter
