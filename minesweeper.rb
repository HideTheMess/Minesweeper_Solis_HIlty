class Board
  def initialize
    @board = []
    81.times { @board << Tile.new() }
    @bombs = 10
  end

  def place_bombs
    arry = @board.combination(@bombs).sample # .entries.sample
  end
end

class Tile
  def initialize(x, y, board, bomb)
    @flag = false
    @pos = [x, y]
    @board = board
    @bomb = bomb
  end

  def reveal







    neighbors.each { |neighbor| neighbor.reveal }
  end

  def bomb_count
  end

  def neigbors
    diff_array = [[-1, 1], [0, 1], [1, 1], [-1, 0], [1, 0], [-1, -1], [0, -1], [1, -1]]

    neigh_pos = diff_array.map { |x_move, y_move| [self.x + x_move, self.y + y_move] }
    neigh_pos.map { |x, y| @board[x][y] }
  end
end