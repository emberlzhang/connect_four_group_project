require 'pry'
# TicTacToe Game
# Play TicTacToe on an h by v board, with Max (first player) playing 'X'.
# A state has the player to move, a cached utility, a list of moves in
# the form of a list of [x, y] positions, and a board, in the form of
# a hash of { [x, y] => Player } entries, where Player is 'X' or 'O'


class TicTacToe
  attr_accessor :moves, :to_move, :h, :v, :k, :utility, :board

  def initialize(h=3, v=3, k=3)
    # Build a list of [x,y] available moves
    @h, @v, @k = h, v, k
    @to_move = 'x'
    @utility = 0 # 0 draw, -1 player2, 1 player1
    @board = {}
    @moves = initial_moves
  end

  def legal_moves
    moves
  end

  def successors(s=[])
    self.legal_moves.each do |move|
      succ = self.deepcopy
      succ.make_move(move)
      s << [move, succ]
    end
    return s
  end

  def deepcopy
    Marshal.load( Marshal.dump(self) )
  end

  def make_move(move)
    # move = [x,y]
    raise ArgumentError, "Invalid move" unless legal_moves.member?(move)

    # Add the move to the board. Key is move, value is player that moved -- working
    board[move] = to_move

    # Update the available moves -- working
    @moves = @moves.delete_if {|e| e == move }

    #Compute game utility -- working
    compute_utility(move)

    # Switch players -- working
    if @to_move == 'x'
      @to_move = 'o'
    else
      @to_move = 'x'
    end
    return
  end

  def over?
    # A game state is over if it is won or there are no empty squares.
    @utility !=0 || @moves.length == 0
  end

  def display_board
    x_moves.each do |x|
      puts
      y_moves.each do |y|
        print "#{@board.fetch([x,y],'.')} "
      end
    end
  end

  def compute_utility(move)
    if deltas.any? {|delta| k_in_row?(move,delta) }
      @utility = 1 if @to_move == 'x'
      @utility = -1 if @to_move == 'o'
    end
  end

  def deltas
    [[0,1],[1,0],[1,-1],[1,1]]
  end

  def k_in_row?(move,delta)
    x,y = move
    n = 0
    while board.fetch([x,y],"") == @to_move
      n += 1
      x, y = x + delta[0], y + delta[1]
    end
    x,y = move
    while board.fetch([x,y],"") == @to_move
      n += 1
      x, y = x - delta[0], y - delta[1]
    end
    n -= 1
    return n >= @k
  end

  def initial_moves(result=[])
    x_moves.each do |x|
      y_moves.each do |y|
        result << [x,y]
      end
    end
    result
  end

  def x_moves
    (1..h)
  end

  def y_moves
    (1..v)
  end
end #TicTacToe


#   A TicTacToe-like game in which you can only make a move on the bottom
#   row, or in a square directly above an occupied square.  Traditionally
#   played on a 7x6 board and requiring 4 in a row.
class ConnectFour < TicTacToe
  def initialize
    super(7,6,4)
  end

  def legal_moves(legal=[])
    @moves.each do |move|
      x,y = move
      legal << move if y == 1 || @board.member?([x,y-1])
    end
    legal
  end

  def make_move(column)
    # [[x,y],[x,y],[x,y]]
    # x = move.first # If getting a move of the form [x,y] use this
    move = legal_moves.select {|m| m[0] == column}.first #returns [x,y] move
    raise ArgumentError, "Invalid move" unless legal_moves.member?(move)

    # Add the move to the board. Key is move, value is player that moved -- working
    board[move] = to_move

    # Update the available moves -- working
    @moves = @moves.delete_if {|e| e == move }

    #Compute game utility -- NOT WORKING
    compute_utility(move)

    # Switch players -- working
    if @to_move == 'x'
      @to_move = 'o'
    else
      @to_move = 'x'
    end
    return
  end
end #ConnectFour