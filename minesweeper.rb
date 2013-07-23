require 'yaml'

class Board
  attr_accessor :board

  def initialize(bomb_count = 10)
    @board = populate_board
    @bombs = bomb_count
    @gameover = false
  end

  def populate_board
    board = []
    9.times do |row|
      temp_array = []
      9.times do |col|
        temp_array << Tile.new(row, col, self) # Maybe '@board'?
      end
      board << temp_array
    end
    board
  end

  def play
    place_bombs

    until @gameover || won?
      p "gameover = #{@gaveover}"
      print_board
      puts ''
      puts 'Coordinates? (comma separated)'
      coord = gets.chomp.split(',').map(&:to_i)
      r, c = coord
      @board[r][c].reveal
    end

    if won?
      puts 'good job'
      return
    else
      puts 'u suck'
      return
    end
  end

  def won?
    board.each do |row|
      row.each do |tile|
        cond1 = (tile.revealed == true && tile.bomb == false)
        cond2 = (tile.revealed == false && tile.bomb == true)
        return false unless cond1 || cond2
      end
    end
    true
  end

  def place_bombs
    (0..8).to_a.repeated_permutation(2).entries.shuffle[0...@bombs].each do |r, c|
      @board[r][c].bomb = true
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

  def save_game
    yam = self.to_yaml
    f = File.open('minesweeper.yml', 'w')
    f.print(yam)
    f.close
  end

  def load_game
    f = File.open('minesweeper.yml', 'r')
    yaml_output = YAML.load(f)
    f.close
    yaml_output
  end

  def gameover
    @gameover = true
  end
end






#---------------------------------------------------------------
class Tile
  attr_accessor :bomb, :revealed

  def initialize(row, col, board)
    @flag = false
    @pos = [row, col]
    @board = board
    @bomb = false
    @revealed = false
  end

  def reveal
    return if @flag
    @revealed = true

    if bomb?
      @board.gameover
    end

    return if bomb_count > 0

    queue = []
    queue += neighbors

    until queue.empty?
      tile = queue.shift
      if tile.bomb_count == 0
        tile.revealed = true
        queue.concat(tile.neighbors)
        queue.delete_if { |neigh| neigh.revealed }
      else
        tile.revealed = true
      end
    end

  end

  def flag
    @flag = !@flag
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

    neigh_pos = diff_array.map { |r_move, c_move| [@pos[0] + r_move, @pos[1] + c_move] }
    neigh_pos.select! do |row, col|
      row.between?(0, 8) && col.between?(0, 8)
    end
    neigh_pos.map { |row, col| @board.board[row][col] }
  end





  def to_s
    if @flag
      return 'P'
    # elsif bomb?
#       return '*'
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