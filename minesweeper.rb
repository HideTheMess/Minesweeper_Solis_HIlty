class Board
  attr_accessor :gameover

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
      # Display board
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
    puts "8 |# # # # # # # # #|"
    puts "7 |# # # # # # # # #|"
    puts "6 |# # # # # # #    |"
    puts "5 |# # # # # # #    |"
    puts "4 |# # # # 5 # # #  |"
    puts "3 |# # # 1     # # #|"
    puts "2 |# # #       2 # #|"
    puts "1 |# # # # # # # # #|"
    puts "0 |# # # # # # # # #|"
    puts '  -------------------'
    puts "   0 1 2 3 4 5 6 7 8"
  end
end

class Tile
  attr_accessor :bomb

  def initialize(x, y, board
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
    neighbors.inject(0) { |accum, neigh| accum + 1 if neigh.bomb? }
  end

  def bomb?
    @bomb
  end

  def neigbors
    diff_array = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]]

    neigh_pos = diff_array.map { |x_move, y_move| [self.x + x_move, self.y + y_move] }
    neigh_pos.map { |x, y| @board[x][y] }
  end
end