class Board
  attr_accessor :board, :gameover

  def initialize(bomb_count = 10)
    @board = populate_board
    @bombs = bomb_count
    @gameover = false
  end

  def populate_board
    board = []
    9.times do |x|
      temp_array = []
      9.times do |y|
        temp_array << Tile.new(x, y, self) # Maybe '@board'?
      end
      board << temp_array
    end
    board
  end

  def play
    until @gameover
      print_board
      # Get user input
      # Let reveal do its thing
    end

    if won?
      puts 'good job'
      return
    else
      puts 'u suck'
      return
    end
  end

  def place_bombs
    (0..8).to_a.repeated_permutation(2).entries.shuffle[0...@bombs].each do |x, y|
      @board[x][y].bomb = true
    end
  end

  def print_board
    puts '  -------------------'
    puts "8 |#{@board[8].join(' ')}|"
    puts "7 |#{@board[7].join(' ')}|"
    puts "6 |#{@board[6].join(' ')}|"
    puts "5 |#{@board[5].join(' ')}|"
    puts "4 |#{@board[4].join(' ')}|"
    puts "3 |#{@board[3].join(' ')}|"
    puts "2 |#{@board[2].join(' ')}|"
    puts "1 |#{@board[1].join(' ')}|"
    puts "0 |#{@board[0].join(' ')}|"
    puts '  -------------------'
    puts "   0 1 2 3 4 5 6 7 8"
  end

  def to_s
  end
end

class Tile
  attr_accessor :bomb, :revealed

  def initialize(x, y, board)
    @flag = false
    @pos = [x, y]
    @board = board
    @bomb = false
    @revealed = false
  end

  def reveal

    if bomb
      @board.gameover == true
    end





    neighbors.each { |neighbor| neighbor.reveal } if no bomb or no bomb nearby
  end

  def bomb_count
    accum = 0

    neighbors.each { |neigh| accum += 1 if neigh.bomb? }
    accum
  end

  def bomb?
    @bomb
  end

  def neighbors
    diff_array = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]]

    neigh_pos = diff_array.map { |x_move, y_move| [@pos[0] + x_move, @pos[1] + y_move] }
    neigh_pos.map { |x, y| @board.board[x][y] }
  end

  def to_s
    if @flag
      return 'P'
    elsif bomb?
      return '*'
    elsif !@revealed
      return 'H'
    # elsif bomb?
#       return '*'
    else
      # numbers
      if bomb_count > 0 # bomb_count
        return bomb_count.to_s
      else
        return ' '
      end
    end
  end
end