require 'diff-lcs'
require_relative './twitterreader'

class TwitterPlayer

	attr_accessor :twitter_name, :unique_key, :listener, :last_board, :new_board

	def initialize
		@listener = TwitterReader.new
		@last_board = "."*42
		@new_board = "."*42
	end

	# Get the Twitter opponents move--as a column number
	def get_move
		twitter_board!
		column_move
	end

	def twitter_board!
		# a string of the form: "@username blablabla |.......|.......|.......|.......|...XO..|..XOX..| #uniquekey #dbc_c4"
		#Set old board to new board, before getting new board
		last_board = new_board
		# Sets new_board as a string in the form ...............................XO....XOX.."
		new_board = to_string!(listener.get_move)
	end

	def column_move
		# Add 1 to the index to convert to column number
		column_diff(last_board,new_board) + 1
	end

	def to_string!(board)
		board.scan(/[XO\.]{7}/).join
	end

	private
	def board_rows(board,rows = [])
		rows = []
		board.split('').each_slice(7).each do |slice|
			rows << slice
		end
		rows
	end

	def board_columns(board)
		board_rows(board).transpose
	end

	def col_values(board)
		# Return an array of columns representing the board with 1s for piece, 0 no piece
		board_columns(board).each do |col|
			col.each do |v|
				v.gsub!(".","0")
				v.gsub!("X","1")
				v.gsub!("O","1")
			end
		end.each {|col| col.map!(&:to_i) }
	end

	def column_sums(board,sums=[])
		# Output ==> [0, 0, 1, 2, 2, 0, 0] starting at column 1, counts pieces in column
		col_values(board).each {|col| sums << col.reduce(&:+) }
		return sums
	end

	def column_diff(board1,board2)
		# Returns index where the two arrays are different
		col1, col2 = column_sums(board1), column_sums(board2)
		Diff::LCS.diff(col1, col2).first.first.position
	end
end #TwitterPlayer